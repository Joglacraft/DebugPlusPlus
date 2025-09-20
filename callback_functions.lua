
function G.FUNCS.DPP_main_menu()
    if G.OVERLAY_MENU then
        G.OVERLAY_MENU:remove()
    end
    DPP.local_config.is_open = true
    G.OVERLAY_MENU = UIBox{
        definition = DPP.main_menu(),
        config = {
            align = "cm",
            offset = {x=0,y=0},
            major = G.ROOM_ATTACH,
            bond = 'Weak',
            no_esc = false
        },
    }
end

function G.FUNCS.DPP_dropdown_tab (e)
    if not e or not e.config then e = {config = {}} end
    if G.OVERLAY_MENU then
        G.OVERLAY_MENU:remove()
    end
    G.OVERLAY_MENU = UIBox{
        definition = DPP.dropdown_tab(e.config.ref_table),
        config = {
            align = "cm",
            offset = {x=0,y=0},
            major = G.ROOM_ATTACH,
            bond = 'Weak',
            no_esc = false
        },
    }
end

function G.FUNCS.DPP_reload_inspector_ui(e)
    local card = e.config.ref_table.card
    local target = e.config.ref_table.target
    local path = e.config.ref_table.path
    local s_path = 'card'
    local page = e.config.ref_table.page

    

    -- Change path
    if target ~= nil then
        if target == false then path[#path] = nil
        else path[#path+1] = target end
    end

    for _,v in ipairs(path) do
        s_path = s_path.."/"..v
    end

    card.DPP_data.inspector.path = path

    if page then card.DPP_data.inspector.pages[s_path] = page
    else page = card.DPP_data.inspector.pages[s_path] end

    -- Remove card's UI box
    if card.children.DPP_card_info then
        card.children.DPP_card_info:remove()
        card.children.DPP_card_info = nil
    end

    -- Re-generate card's UI box
    card.children.DPP_card_info = UIBox{
    definition = DPP.card_inspector_UI(card, path, page),
    config = {
        align = (card.playing_card and "tm" or "bm"),
        offset = {x=0,y=0},
        r_bond = 'Weak',
        r = 0,
        parent = card
    }
}
end

function G.FUNCS.DPP_reload_lists(e)
    if G.OVERLAY_MENU then
        G.OVERLAY_MENU:remove()
    end
    DPP.vars.pages[e.config.ref_table[1]] = DPP.vars.pages[e.config.ref_table[1]] + e.config.ref_table[2]
    DPP.reload_lists()
    G.FUNCS.DPP_main_menu()
end

function G.FUNCS.DPP_set_area_limit(e)
   local area = e.config.ref_table[1]
   local limit = e.config.ref_table[2]
   if G[area] then
      G[area].config.card_limit = G[area].config.card_limit + limit
   end
end

function G.FUNCS.DPP_set_highlighted_limit(e)
   local area = e.config.ref_table[1]
   local limit = e.config.ref_table[2]
   if G[area] then
      G[area].config.highlighted_limit = G[area].config.highlighted_limit + limit
   end
end


function G.FUNCS.DPP_change_menu_background(args)
    DPP.config.background_colour.number = args.cycle_config.current_option
    if args.to_val == "None" then DPP.config.background_colour.selected = "CLEAR"
    elseif args.to_val == "Black" then DPP.config.background_colour.selected = "BLACK"
    end
    G.FUNCS.DPP_main_menu()
end

function G.FUNCS.DPP_set_rank(e)
    if not G.hand then return end
    for _,v in pairs(G.hand.highlighted) do
        _ = SMODS.change_base(v,nil,e.config.ref_table[1])
    end
end

function G.FUNCS.DPP_set_suit(e)
    if not G.hand then return end
    for _,v in pairs(G.hand.highlighted) do
        _ = SMODS.change_base(v,e.config.ref_table[1],nil)
    end
end

function G.FUNCS.DPP_set_enhancement(e)
    if not G.hand then return end
    for _,v in pairs(G.hand.highlighted) do
        v:set_ability(e.config.ref_table[1])
    end
end

function G.FUNCS.DPP_set_edition(e)
    if not G.hand or not G.consumeables then return end
    for _,v in pairs(G.hand.highlighted) do
        v:set_edition(e.config.ref_table[1],true,true)
    end
    for _,v in pairs(G.jokers.highlighted) do
        v:set_edition(e.config.ref_table[1],true,true)
    end
    for _,v in pairs(G.consumeables.highlighted) do
        v:set_edition(e.config.ref_table[1],true,true)
    end
end

function G.FUNCS.DPP_set_seal(e)
    if not G.hand then return end
    if e.config.ref_table[1] == "None" then
        for _,v in pairs(G.hand.highlighted) do
            v:set_seal(nil,true,true)
        end
        for _,v in pairs(G.jokers.highlighted) do
            v:set_seal(nil,true,true)
        end
        for _,v in pairs(G.consumeables.highlighted) do
            v:set_seal(nil,true,true)
        end
    else
        for _,v in pairs(G.hand.highlighted) do
            v:set_seal(e.config.ref_table[1],true,true)
        end
        for _,v in pairs(G.jokers.highlighted) do
            v:set_seal(e.config.ref_table[1],true,true)
        end
        for _,v in pairs(G.consumeables.highlighted) do
            v:set_seal(e.config.ref_table[1],true,true)
        end
    end
end

function G.FUNCS.DPP_set_sticker (e)
    if G.jokers then
        for _,v in ipairs(G.jokers.highlighted) do
            SMODS.Stickers[e.config.ref_table[1]]:apply(v,not v.ability[e.config.ref_table[1]])
        end
    end
    if G.consumeables then
        for _,v in ipairs(G.consumeables.highlighted) do
            SMODS.Stickers[e.config.ref_table[1]]:apply(v,not v.ability[e.config.ref_table[1]])
        end
    end
    if G.hand then
        for _,v in ipairs(G.hand.highlighted) do
            SMODS.Stickers[e.config.ref_table[1]]:apply(v,not v.ability[e.config.ref_table[1]])
        end
    end
end

function G.FUNCS.DPP_ease_hands(e)
    if not G.jokers then return end
    ease_hands_played(e.config.ref_table[1],true)
end

function G.FUNCS.DPP_ease_discards(e)
    if not G.jokers then return end
    ease_discard(e.config.ref_table[1],true)
end


function G.FUNCS.DPP_set_money(e)
    DPP.run.dollars = to_big(DPP.replace_text_input(DPP.run.dollars)) or DPP.run.dollars
    if not G.jokers then return end
    if e.config.ref_table[1] == "set" then
        ease_dollars(DPP.run.dollars-G.GAME.dollars,true)
    elseif e.config.ref_table[1] == "var" then
        ease_dollars(DPP.run.dollars,true)
    end
end

function G.FUNCS.DPP_set_chips(e)

    DPP.run.chips = tonumber(DPP.run.chips) or DPP.run.chips

    if tonumber(DPP.run.chips) then
        if e.config.ref_table[1] == "set" then
            G.GAME.chips = to_big(DPP.run.chips)
        elseif e.config.ref_table[1] == "var" then
            G.GAME.chips = to_big(G.GAME.chips + DPP.run.chips)
        end
    end
end

function G.FUNCS.DPP_set_blind_chips(e)
    DPP.run.blind_chips = tonumber(DPP.run.blind_chips) or DPP.run.blind_chips

    if G.GAME.blind and tonumber(DPP.run.blind_chips) then
        if e.config.ref_table[1] == "set" then
            G.GAME.blind.chips = to_big(DPP.run.blind_chips)
        elseif e.config.ref_table[1] == "var" then
            G.GAME.blind.chips = to_big(G.GAME.blind.chips + DPP.run.blind_chips)
        end
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
        G.HUD_blind:recalculate()
    end
end

function G.FUNCS.DPP_set_blind(e)
    if not G.blind_select then return end
    local par = G.blind_select_opts.boss.parent
    if e.config.ref_table[1] == "Random" then
        G.GAME.round_resets.blind_choices.Boss = get_new_boss()
    else
        G.GAME.round_resets.blind_choices.Boss = e.config.ref_table[1]
    end

    G.blind_select_opts.boss = UIBox{
        T = {par.T.x, 0, 0, 0, },
        definition =
        {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
            UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
        }},
        config = {align="bmi",
                offset = {x=0,y=G.ROOM.T.y + 9},
                major = par,
                xy_bond = 'Weak'
                }
    }
    par.config.object = G.blind_select_opts.boss
    par.config.object:recalculate()
    G.blind_select_opts.boss.parent = par
    G.blind_select_opts.boss.alignment.offset.y = 0
end

function G.FUNCS.DPP_set_ante(e)
    if not G.jokers then return end
    ease_ante(e.config.ref_table[1])
end

function G.FUNCS.DPP_set_round(e)
    if not G.jokers then return end
    ease_round(e.config.ref_table[1])
end

function G.FUNCS.DPP_set_gamespeed(e)

    DPP.gamespeed = tonumber(DPP.gamespeed) or DPP.gamespeed

    if tonumber(DPP.gamespeed) then
        G.SETTINGS.GAMESPEED = tonumber(DPP.gamespeed)/e.config.ref_table[1]
    end
end