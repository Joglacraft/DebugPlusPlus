local ref = Game.update
function Game:update(dt)
    if not DPP.vars then DPP.vars = {} end

    if DPP.vars.unlimited_hands then
        G.GAME.current_round.hands_left = DPP.vars.hands
    end
    if DPP.vars.unlimited_discards then
        G.GAME.current_round.discards_left = DPP.vars.discards
    end
    if DPP.vars.unlimited_money then
        G.GAME.dollars = DPP.vars.dollars
    end

    -- Update the internal variables for DynaTexts
    if G.hand and G.hand.config then
        DPP.vars.hand_size = G.hand.config.card_limit
        DPP.vars.hand_highlight = G.hand.config.highlighted_limit
    else
        DPP.vars.hand_size = 0
        DPP.vars.hand_highlight = 0
    end
    if G.GAME and G.GAME.current_round then
        DPP.vars.hands = G.GAME.current_round.hands_left
        DPP.vars.discards = G.GAME.current_round.discards_left
    else
        DPP.vars.hands = 0
        DPP.vars.discards = 0
    end
    if G.jokers and G.jokers.config then
        DPP.vars.joker_size = G.jokers.config.card_limit
        DPP.vars.joker_highlight = G.jokers.config.highlighted_limit
    else
        DPP.vars.joker_size = 0
        DPP.vars.joker_highlight = 0
    end
    if G.consumeables and G.consumeables.config then
        DPP.vars.consumeable_size = G.consumeables.config.card_limit
        DPP.vars.consumeable_highlight = G.consumeables.config.highlighted_limit
    else
        DPP.vars.consumeable_size = 0
        DPP.vars.consumeable_highlight = 0
    end
    if G and G.GAME then
        DPP.vars.dollars = G.GAME.dollars or 0
    else
        DPP.vars.dollars = 0
    end

    return ref(self,dt)
end

local ref = create_UIBox_options

function create_UIBox_options(args)  
    local tbl = ref()
    if DPP.config.display_menu_button then
        local dpp_button = UIBox_button{ label = {localize("dpp_name")}, button = "DPP_main_menu", minw = 2.4}
        local exists = false
        local t_node = tbl.nodes[1].nodes[1].nodes[1].nodes

        for k,v in pairs(t_node) do
            if v.nodes[1].config and v.nodes[1].config.button == "settings" then
                v.nodes[1].nodes[1].config.minw = 2.4
                local btn = v
                t_node[k] = {n = G.UIT.R, nodes = {{n = G.UIT.C, nodes = {
                    {n = G.UIT.C, nodes = {dpp_button}},
                    {n = G.UIT.C, config = {minw = 0.2}},
                    {n = G.UIT.C, nodes = {btn}},
                }}}}
                exists = true
            end 
        end

        for k,v in pairs(t_node) do
            if v.nodes[1].config and v.nodes[1].config.button == "setup_run" then
                v.nodes[1].nodes[1].config.minw = 2.4
                t_node[4].nodes[1].nodes[1].config.minw = 2.4
                local old_new_run = t_node[3]
                local old_go_menu = t_node[4]
                t_node[3] = {n = G.UIT.R, nodes = {{n = G.UIT.C, nodes = {
                    {n = G.UIT.C, nodes = {old_new_run}},
                    {n = G.UIT.C, config = {minw = 0.2}},
                    {n = G.UIT.C, nodes = {old_go_menu}},
                }}}}
                t_node[4] = nil
            end
        end

        if not exists then
            dpp_button = UIBox_button{ label = {localize("dpp_name")}, button = "DPP_main_menu", minw = 5}
            table.insert(tbl.nodes[1].nodes[1].nodes[1].nodes,1,dpp_button)
        end
    end
    --if DPP.config.display_menu_button then table.insert(tbl.nodes[1].nodes[1].nodes[1].nodes,1,dpp_button) end
    return tbl
end