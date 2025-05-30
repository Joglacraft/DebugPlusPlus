
function G.FUNCS.DPP_main_menu()
      G.FUNCS.overlay_menu{
         definition = DPP.main_menu(),
         config = {no_esc = true},
         pause = false
    }
end

function G.FUNCS.DPP_reload_lists()
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

function G.FUNCS.DPP_update_rank(args)
   DPP.card.rank.number = args.cycle_config.current_option
   DPP.card.rank.selected = args.to_val
end

function G.FUNCS.DPP_set_rank()
    if not G.hand then return end
    for _,v in pairs(G.hand.highlighted) do
        _ = SMODS.change_base(v,nil,DPP.card.rank.selected)
    end
end

function G.FUNCS.DPP_update_suit(args)
   DPP.card.suit.number = args.cycle_config.current_option
   DPP.card.suit.selected = args.to_val
end

function G.FUNCS.DPP_set_suit()
    if not G.hand then return end
    for _,v in pairs(G.hand.highlighted) do
        _ = SMODS.change_base(v,DPP.card.suit.selected,nil)
    end
end

function G.FUNCS.DPP_update_enhancement(args)
    DPP.card.enhancement.number = args.cycle_config.current_option
    DPP.card.enhancement.selected = args.to_val
end

function G.FUNCS.DPP_set_enhancement()
    if not G.hand then return end
    for _,v in pairs(G.hand.highlighted) do
        v:set_ability(DPP.card.enhancement.key[DPP.card.enhancement.number])
    end
end

function G.FUNCS.DPP_update_edition(args)
    DPP.card.edition.number = args.cycle_config.current_option
    DPP.card.edition.selected = args.to_val
end

function G.FUNCS.DPP_set_edition()
    if not G.hand or not G.consumeables then return end
    for _,v in pairs(G.hand.highlighted) do
        v:set_edition(DPP.card.edition.key[DPP.card.edition.number],true,true)
    end
    for _,v in pairs(G.jokers.highlighted) do
        v:set_edition(DPP.card.edition.key[DPP.card.edition.number],true,true)
    end
    for _,v in pairs(G.consumeables.highlighted) do
        v:set_edition(DPP.card.edition.key[DPP.card.edition.number],true,true)
    end
end

function G.FUNCS.DPP_update_seal(args)
    DPP.card.seal.number = args.cycle_config.current_option
    DPP.card.seal.selected = args.to_val
end

function G.FUNCS.DPP_set_seal()
    if not G.hand then return end
    if DPP.card.seal.selected == "None" then
        for _,v in pairs(G.hand.highlighted) do
            v.seal = nil
        end
        for _,v in pairs(G.jokers.highlighted) do
            v.seal = nil
        end
        for _,v in pairs(G.consumeables.highlighted) do
            v.seal = nil
        end
    else
        for _,v in pairs(G.hand.highlighted) do
            v.seal = DPP.card.seal.selected
        end
        for _,v in pairs(G.jokers.highlighted) do
            v.seal = DPP.card.seal.selected
        end
        for _,v in pairs(G.consumeables.highlighted) do
            v.seal = DPP.card.seal.selected
        end
    end
end

function G.FUNCS.DPP_update_sticker(args)
    DPP.card.sticker.number = args.cycle_config.current_option
    DPP.card.sticker.selected = args.to_val
end

function G.FUNCS.DPP_add_sticker()
    if not G.jokers then return end
    for _,v in pairs(G.hand.highlighted) do
        v.ability[DPP.card.sticker.selected] = true
    end
    for _,v in pairs(G.jokers.highlighted) do
        v.ability[DPP.card.sticker.selected] = true
    end
    for _,v in pairs(G.consumeables.highlighted) do
        v.ability[DPP.card.sticker.selected] = true
    end
end

function G.FUNCS.DPP_remove_sticker()
    if not G.jokers then return end
    for _,v in pairs(G.hand.highlighted) do
        v.ability[DPP.card.sticker.selected] = nil
    end
    for _,v in pairs(G.jokers.highlighted) do
        v.ability[DPP.card.sticker.selected] = nil
    end
    for _,v in pairs(G.consumeables.highlighted) do
        v.ability[DPP.card.sticker.selected] = true
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
    if not G.jokers then return end
    ease_dollars(e.config.ref_table[1],true)
end

function G.FUNCS.DPP_set_chips(e)
    if tonumber(DPP.run.chips) then
        DPP.run.chips = tonumber(DPP.run.chips)
        DPP.run.chips =  math.abs(DPP.run.chips)
        if e.config.ref_table[1] == "subtract" then
            G.GAME.chips = G.GAME.chips - DPP.run.chips
        elseif e.config.ref_table[1] == "set" then
            G.GAME.chips = DPP.run.chips
        elseif e.config.ref_table[1] == "add" then
            G.GAME.chips = G.GAME.chips + DPP.run.chips
        end
    end
end

function G.FUNCS.DPP_set_blind_chips(e)
    if G.GAME.blind and tonumber(DPP.run.blind_chips) then
        DPP.run.blind_chips = tonumber(DPP.run.blind_chips)
        DPP.run.chips =  math.abs(DPP.run.chips)
        if e.config.ref_table[1] == "subtract" then
            G.GAME.blind.chips = G.GAME.blind.chips - DPP.run.blind_chips
        elseif e.config.ref_table[1] == "set" then
            G.GAME.blind.chips = DPP.run.blind_chips
        elseif e.config.ref_table[1] == "add" then
            G.GAME.blind.chips = G.GAME.blind.chips + DPP.run.blind_chips
        end
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
        G.HUD_blind:recalculate()
    end
end

function G.FUNCS.DPP_change_blind(args)
    DPP.blind.number = args.cycle_config.current_option
    DPP.blind.selected = args.to_val
end

function G.FUNCS.DPP_set_blind()
    if not G.blind_select then return end
    local par = G.blind_select_opts.boss.parent
    if DPP.blind.selected == "Random" then
        G.GAME.round_resets.blind_choices.Boss = get_new_boss()
    else
        G.GAME.round_resets.blind_choices.Boss = DPP.blind.key[DPP.blind.number]
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

function G.FUNCS.DPP_set_gamespeed(e)
    if tonumber(DPP.gamespeed) then
        G.SETTINGS.GAMESPEED = tonumber(DPP.gamespeed)/e.config.ref_table[1]
    end
end