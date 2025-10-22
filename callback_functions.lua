
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
    local card = e.config.ref_table.card -- The card object
    local target = e.config.ref_table.target -- The path to attatch
    local path = e.config.ref_table.path -- The current path
    local s_path = 'card' -- The path as a astring
    local page = e.config.ref_table.page -- The current page

    

    -- Change path
    if target ~= nil then
        -- Remove last path entry
        if target == false then path[#path] = nil
        -- Add target to path entry
        else path[#path+1] = target end
    end

    -- String formatting for the string path display
    for _,v in ipairs(path) do
        s_path = s_path.."/"..v
    end

    -- Update the card's stored path for if the menu is closed and re-opened
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

function G.FUNCS.DPP_inspector_variable(e)
    local card = e.config.ref_table.card -- The card object
    local target = e.config.ref_table.target -- The path to attatch
    local path = e.config.ref_table.path -- The current path
    local t_path = card -- The actual path to the data, excluding the last key
    local s_path = 'card' -- The path as a astring
    local page = e.config.ref_table.page -- The current page

    -- String formatting for the string path display
        if #path <= 3 then
        for i=1, #path do
            s_path = s_path.."/"..path[i]
        end
    else
        s_path = s_path.."/.../"..path[#path-1].."/"..path[#path]
    end
    if string.len(s_path) > 20 then
        s_path = "..."..string.sub(s_path,string.len(s_path)-17,string.len(s_path))
    end

    -- Navigate through the path, starting at the card
    for _,v in ipairs(path) do
        t_path = t_path[v]
    end

    DPP.vars.inspector.val = target and tostring(t_path[target]) or ''
    DPP.vars.inspector.new = ''

    G.FUNCS.overlay_menu{
        definition = {n = G.UIT.ROOT, config = {colour = G.C[DPP.config.background_colour.selected], align = "cm", padding = 0.2, r = 0.1, outline = 1, outline_colour = G.C.WHITE}, nodes = {
            {n = G.UIT.R, config = {align = 'cm', padding = 0.1}, nodes = {
                {n = G.UIT.R, config = {align = 'tm'}, nodes = {
                    {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {align = 'tm', text = s_path, colour = G.C.WHITE, scale = 0.5}}}},
                    target and {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {align = 'tm', text = tostring(type(t_path[target])), colour = G.C.GREY, scale = 0.4}}}},
                }},
            }},
            {n = G.UIT.R, config = {align = 'cm', padding = 0.1, minw = 3, minh = 5}, nodes = {
                {n = G.UIT.R, config = {align = "cm", minh = 0.3}, nodes = {{n = G.UIT.T, config = {text = 'Name', scale = 0.3, colour = G.C.WHITE}}}},
                (not target and
                {n = G.UIT.R, config = {align = 'cm'}, nodes = {
                    DPP.create_text_input{
                    id = 'name',
                    ref_table = DPP.vars.inspector,
                    ref_value = 'new',
                    max_lenght = 60,
                    w = 5
                    }
                }}
                or nil),
                (target and 
                {n = G.UIT.R, config = {align = 'cm'}, nodes = {{n = G.UIT.T, config = {text = tostring(target), scale = 0.4, colour = G.C.WHITE}}}} or nil),
                {n = G.UIT.R, config = {align = "cm", minh = 0.3}, nodes = {{n = G.UIT.T, config = {text = 'Value', scale = 0.3, colour = G.C.WHITE}}}},
                {n = G.UIT.R, config = {align = 'cm'}, nodes = {
                    DPP.create_text_input{
                        id = 'value',
                        ref_table = DPP.vars.inspector,
                        ref_value = 'val',
                        max_lenght = 60,
                        w = 5
                    }
                }},
                {n = G.UIT.R, config = {align = "cm", minh = 0.3}, nodes = {{n = G.UIT.T, config = {text = 'Type', scale = 0.3, colour = G.C.WHITE}}}},
                {n = G.UIT.R, config = {align = 'cm'}, nodes = {
                    {n = G.UIT.C, config = {align = 'cm'}, nodes = {
                        UIBox_adv_button{
                            label = {{{'String'}}},
                            text_scale = 0.4,
                            w = 1.8, h = 0.5,
                            button = "DPP_inspector_variable_set",
                            func = "DPP_inspector_variable_check",
                            ref_table = {type = 'string', card = card, path = path, rt = t_path, rv = target, page = page, value = DPP.vars.inspector.val}
                        },
                    }},
                    {n = G.UIT.C, config = {align = 'cm'}, nodes = {
                        UIBox_adv_button{
                            label = {{{'Number'}}},
                            text_scale = 0.4,
                            w = 1.8, h = 0.5,
                            button = "DPP_inspector_variable_set",
                            func = "DPP_inspector_variable_check",
                            ref_table = {type = 'string', card = card, path = path, rt = t_path, rv = target, page = page, value = DPP.vars.inspector.val}
                        },
                    }},
                }},
                {n = G.UIT.R, config = {align = 'cm'}, nodes = {
                    {n = G.UIT.C, config = {align = 'cm'}, nodes = {
                        UIBox_adv_button{
                            label = {{{'Boolean'}}},
                            text_scale = 0.4,
                            w = 1.8, h = 0.5,
                            button = "DPP_inspector_variable_set",
                            func = "DPP_inspector_variable_check",
                            ref_table = {type = 'boolean', card = card, path = path, rt = t_path, rv = target, page = page, value = DPP.vars.inspector.val}
                        },
                    }},
                    {n = G.UIT.C, config = {align = 'cm'}, nodes = {
                        UIBox_adv_button{
                            label = {{{'Table'}}},
                            text_scale = 0.4,
                            w = 1.8, h = 0.5,
                            button = "DPP_inspector_variable_set",
                            func = "DPP_inspector_variable_check",
                            ref_table = {type = 'table', card = card, path = path, rt = t_path, rv = target, page = page}
                        },
                    }},
                }},
                target and {n = G.UIT.R, config = {align = 'cm'}, nodes = {
                    {n = G.UIT.C, config = {align = 'cm'}, nodes = {
                        UIBox_adv_button{
                            label = {{{'Remove'}}},
                            text_scale = 0.4,
                            w = 1.8, h = 0.5,
                            button = "DPP_inspector_variable_set",
                            func = "DPP_inspector_variable_check",
                            ref_table = {type = 'remove', card = card, path = path, rt = t_path, rv = target, page = page}
                        },
                    }},
                }} or nil
            }},
            UIBox_adv_button{
                label = {{{localize("b_back")}}},
                colour = G.C.ORANGE,
                text_scale = 0.5,
                w = 5, h = 0.6,
                button = "exit_overlay_menu"
            },
        }},
        config = {
            offset = {x = 0, y = 0}
        }
    }
end

function G.FUNCS.DPP_inspector_variable_set(e)
    local type = e.config.ref_table.type
    local card = e.config.ref_table.card -- The card object
    local ref_value = e.config.ref_table.rv -- The path to attatch
    local path = e.config.ref_table.path -- The current path, as an array
    local ref_table = card -- The actual path to the data, excluding the last key
    local page = e.config.ref_table.page -- The current page

    if DPP.vars.inspector.new ~= '' then ref_value = DPP.vars.inspector.new end

    -- Navigate through the path, starting at the card
    for _,v in ipairs(path) do
        ref_table = ref_table[v]
    end

    if type == 'string' then
        ref_table[ref_value] = tostring(DPP.vars.inspector.val) or 'test'
    elseif type == 'number' then
        ref_table[ref_value] = tonumber(DPP.vars.inspector.val) or 1
    elseif type == 'boolean' then
        ref_table[ref_value] = DPP.vars.inspector.val == 'true' and true or false
    elseif type == 'table' then
        ref_table[ref_value] = {}
    elseif type == 'remove' then
        ref_table[ref_value] = nil
    end

    DPP.vars.inspector.new = ''

    G.FUNCS.DPP_reload_inspector_ui{config = {ref_table = {card = card, path = path, page = page}}}
    if ref_table[ref_value] ~= nil then G.FUNCS.DPP_inspector_variable{config = {ref_table = {card = card, path = path, target = ref_value, page = page}}} else G.FUNCS.exit_overlay_menu() end
end

function G.FUNCS.DPP_inspector_variable_check(e)
    local type = e.config.ref_table.type

    if type == 'String' then
    elseif type == 'number' then
    elseif type == 'boolean' then
    elseif type == 'table' then
    elseif type == 'remove' then
    end
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


function G.FUNCS.DPP_set_currency(e)
    e.config.ref_table.dt[e.config.ref_table.dv] = to_big(DPP.replace_text_input(e.config.ref_table.dt[e.config.ref_table.dv])) or e.config.ref_table.dt[e.config.ref_table.dv]
    if not G.jokers then return end
    if e.config.ref_table.mode == "set" then
        e.config.ref_table.func(e.config.ref_table.dt[e.config.ref_table.dv]-e.config.ref_table.gt[e.config.ref_table.gv],true)
    elseif e.config.ref_table.mode == "var" then
        e.config.ref_table.func(e.config.ref_table.dt[e.config.ref_table.dv],true)
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

function G.FUNCS.DPP_draw_hand (e)
    G.E_MANAGER:add_event(Event({
        func = function()
            if not (G.hand or G.GAME.blind) or G.FUNCS.draw_from_deck_to_hand(nil) then
                return true
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                G.STATE = G.STATES.SELECTING_HAND
                G.STATE_COMPLETE = false
                G.GAME.blind:drawn_to_hand()
                return true
                end
            }))
            return true
        end
    }))
end