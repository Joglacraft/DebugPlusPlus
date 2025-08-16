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
    local dpp_button = UIBox_button{ label = {localize("dpp_name")}, button = "DPP_main_menu", minw = 5}

    local t = create_UIBox_generic_options({ contents = {
        dpp_button,
    }})

    if DPP.config.display_menu_button then table.insert(tbl.nodes[1].nodes[1].nodes[1].nodes,1,dpp_button) end
    return tbl
end