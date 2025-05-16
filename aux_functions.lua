function DPP.reload_lists()

    DPP.card.rank.options = {}
    for _,v in pairs(SMODS.Ranks) do
        DPP.card.rank.options[#DPP.card.rank.options+1] = v.key
    end

    DPP.card.suit.options = {}
    for _,v in pairs(SMODS.Suits) do
        DPP.card.suit.options[#DPP.card.suit.options+1] = v.key
    end

    DPP.card.enhancement.options = {"None"}
    DPP.card.enhancement.key = {"c_base"}
    for _,v in pairs(G.P_CENTER_POOLS.Enhanced) do
            DPP.card.enhancement.options[#DPP.card.enhancement.options+1] = v.name
            DPP.card.enhancement.key[#DPP.card.enhancement.key+1] = v.key
    end

    DPP.card.edition.options = {}
    DPP.card.edition.key = {}
    for _,v in pairs(G.P_CENTER_POOLS.Edition) do
        DPP.card.edition.options[#DPP.card.edition.options+1] = v.name
        DPP.card.edition.key[#DPP.card.edition.key+1] = v.key
    end

    DPP.card.seal.options = {"None"}
    for _,v in pairs(SMODS.Seals) do
        DPP.card.seal.options[#DPP.card.seal.options+1] = v.key
    end

    DPP.card.sticker.options = {}
    for _,v in pairs(SMODS.Stickers) do
        DPP.card.sticker.options[#DPP.card.sticker.options+1] = v.key
    end

    DPP.blind.options = {"Random"}
    DPP.blind.key = {"random"}
    for _,v in pairs(G.P_BLINDS) do
        DPP.blind.options[#DPP.blind.options+1] = v.name
        DPP.blind.key[#DPP.blind.key+1] = v.key
    end
end

function DPP.reload_default_values()
    DPP.card.rank.selected = DPP.card.rank.options[1]
    DPP.card.suit.selected = DPP.card.suit.options[1]
    DPP.card.enhancement.selected = DPP.card.enhancement.options[1]
    DPP.card.edition.selected = DPP.card.edition.options[1]
    DPP.card.seal.selected = DPP.card.seal.options[1]
    DPP.card.sticker.selected = DPP.card.sticker.options[1]
    DPP.blind.selected = "Random"
end

G.FUNCS.DPP_load_text_input = function(e)
    DPP.run.chips = tostring(DPP.run.chips)
    DPP.run.blind_chips = tostring(DPP.run.blind_chips)
    if not e.config or not e.config.auto_selected then
        if not e.config then e.config = {} end
        e.config.auto_selected = true

        G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function() 
                e.UIBox:recalculate(true) 
                return true 
            end
        }))
    end
end

function DPP.create_text_input(args)
    args = args or {}
    args.colour = copy_table(args.colour) or copy_table(G.C.BLUE)
    args.hooked_colour = copy_table(args.hooked_colour) or darken(copy_table(G.C.BLUE), 0.3)
    args.w = args.w or 2.5
    args.h = args.h or 0.7
    args.text_scale = args.text_scale or 0.4
    args.max_length = args.max_length or 16
    args.all_caps = args.all_caps or false
    args.prompt_text = args.prompt_text or ''
    args.current_prompt_text = ''
    args.id = args.id or "text_input"

    local text = {ref_table = args.ref_table, ref_value = args.ref_value, letters = {}, current_position = string.len(args.ref_table[args.ref_value])}
    local ui_letters = {}
    for i = 1, args.max_length do
        text.letters[i] = (args.ref_table[args.ref_value] and (string.sub(args.ref_table[args.ref_value], i, i) or '')) or ''
        ui_letters[i] = {n=G.UIT.T, config={ref_table = text.letters, ref_value = i, scale = args.text_scale, colour = G.C.UI.TEXT_LIGHT, id = args.id..'_letter_'..i}}
    end
    args.text = text

    local position_text_colour = lighten(copy_table(G.C.BLUE), 0.4)

    ui_letters[#ui_letters+1] = {n=G.UIT.T, config={ref_table = args, ref_value = 'current_prompt_text', scale = args.text_scale, colour = lighten(copy_table(args.colour), 0.4), id = args.id..'_prompt'}}
    ui_letters[#ui_letters+1] = {n=G.UIT.B, config={r = 0.03,w=0.1, h=0.4, colour = position_text_colour, id = args.id..'_position', func = 'flash'}}

    local t = 
        {n=G.UIT.C, config={align = "cm", colour = G.C.CLEAR}, nodes = {
            {n=G.UIT.C, config={id = args.id, align = "cm", padding = 0.05, r = 0.1, hover = true, colour = args.colour,minw = args.w, min_h = args.h, func = "DPP_load_text_input", button = 'select_text_input', shadow = true}, nodes={
                {n=G.UIT.R, config={ref_table = args, padding = 0.05, align = "cm", r = 0.1, colour = G.C.CLEAR}, nodes={
                {n=G.UIT.R, config={ref_table = args, align = "cm", r = 0.1, colour = G.C.CLEAR, func = 'text_input'}, nodes=
                    ui_letters
                }
                }}
            }}
            }}
    return t
end
