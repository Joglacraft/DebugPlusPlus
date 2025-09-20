function DPP.add_tab(args)
    args = args or
    {
        meta = {id = "error"},
        content =       
        {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
            {n = G.UIT.R, config = {align = "cm", minw = DPP.menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
                {n = G.UIT.T,config = {align = "cm", text = "ERROR", scale = 0.4, colour = G.C.WHITE}}
            }}}}
        }},
    }
    table.insert(DPP.TABS,args)
end

function DPP.load_tab(id)
    id = id or "error"
    for _,v in pairs(DPP.TABS) do
        if v.meta.id == id then
            return v.content
        end
    end
end
function DPP.reload_lists()

    DPP.card.rank.options = {}
    for _,v in pairs(SMODS.Ranks) do
        DPP.card.rank.options[#DPP.card.rank.options+1] = v.key
    end
    table.sort(DPP.card.rank.options)

    DPP.card.suit.options = {}
    for _,v in pairs(SMODS.Suits) do
        DPP.card.suit.options[#DPP.card.suit.options+1] = v.key
    end
    table.sort(DPP.card.suit.options)

    DPP.card.enhancement.options = {"c_base"}
    for _,v in pairs(G.P_CENTER_POOLS.Enhanced) do
        DPP.card.enhancement.options[#DPP.card.enhancement.options+1] = v.key
    end
    --table.sort(DPP.card.enhancement.options)

    DPP.card.edition.options = {}
    for _,v in pairs(G.P_CENTER_POOLS.Edition) do
        DPP.card.edition.options[#DPP.card.edition.options+1] = v.key
    end
    --table.sort(DPP.card.edition.options)

    DPP.card.seal.options = {"None"}
    for _,v in pairs(SMODS.Seals) do
        DPP.card.seal.options[#DPP.card.seal.options+1] = v.key
    end
    table.sort(DPP.card.seal.options)

    DPP.card.sticker.options = {}
    for _,v in pairs(SMODS.Stickers) do
        DPP.card.sticker.options[#DPP.card.sticker.options+1] = v.key
    end
    table.sort(DPP.card.sticker.options)

    DPP.blind.options = {"Random"}
    for _,v in pairs(G.P_BLINDS) do
        DPP.blind.options[#DPP.blind.options+1] = v.key
    end
    table.sort(DPP.blind.options)
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

function DPP.create_option_cycle(args)
  args = args or {}
  args.colour = args.colour or G.C.RED
  args.options = args.options or {
    'Option 1',
    'Option 2'
  }
  args.current_option = args.current_option or 1
  args.current_option_val = args.options[args.current_option]
  args.opt_callback = args.opt_callback or nil
  args.scale = args.scale or 1
  args.ref_table = args.ref_table or nil
  args.ref_value = args.ref_value or nil
  args.w = (args.w or 2.5)*args.scale
  args.h = (args.h or 0.8)*args.scale
  args.text_scale = (args.text_scale or 0.5)*args.scale
  args.l = '<'
  args.r = '>'
  args.focus_args = args.focus_args or {}
  args.focus_args.type = 'cycle'

  local info = nil
  if args.info then 
    info = {}
    for k, v in ipairs(args.info) do 
      table.insert(info, {n=G.UIT.R, config={align = "cm", minh = 0.05}, nodes={
        {n=G.UIT.T, config={text = v, scale = 0.3*args.scale, colour = G.C.UI.TEXT_LIGHT}}
      }})
    end
    info =  {n=G.UIT.R, config={align = "cm", minh = 0.05}, nodes=info}
  end

  local disabled = #args.options < 2
  local pips = {}
  for i = 1, #args.options do 
    pips[#pips+1] = {n=G.UIT.B, config={w = 0.1*args.scale, h = 0.1*args.scale, r = 0.05, id = 'pip_'..i, colour = args.current_option == i and G.C.WHITE or G.C.BLACK}}
  end
  
  local choice_pips = not args.no_pips and {n=G.UIT.R, config={align = "cm", padding = (0.05 - (#args.options > 15 and 0.03 or 0))*args.scale}, nodes=pips} or nil

  local t = 
        {n=G.UIT.R, config={align = "cm", padding = 0.1, r = 0.1, colour = G.C.CLEAR, id = args.id and (not args.label and args.id or nil) or nil, focus_args = args.focus_args}, nodes={
          {n = G.UIT.R, config = {align = "cm"}, nodes = {
            {n=G.UIT.C, config={id = 'cycle_main', align = "cm", minw = args.w, minh = args.h, r = 0.1, padding = 0.05, colour = args.colour,emboss = 0.025, hover = true, can_collide = true, on_demand_tooltip = args.on_demand_tooltip}, nodes={
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.T, config={ref_table = args, ref_value = "current_option_val", colour = G.C.UI.TEXT_LIGHT, shadow = true, float = true, silent = true, bump = true, scale = args.text_scale}},
                }},
              }},
            }},
          }},
          {n = G.UIT.R, config = {align = "cm"}, nodes = {
            {n=G.UIT.C, config={align = "cm",r = 0.3, minw = (args.w/2)-0.1, minh = 0.6*args.scale, hover = true, colour = not disabled and args.colour or G.C.BLACK,shadow = not disabled, button = not disabled and 'option_cycle' or nil, ref_table = args, ref_value = 'l'}, nodes={
              {n=G.UIT.T, config={ref_table = args, ref_value = 'l', scale = args.text_scale, colour = not disabled and G.C.UI.TEXT_LIGHT or G.C.UI.TEXT_INACTIVE}}
            }},
            {n=G.UIT.C, config={align = "cm",r = 0.3, minw = (args.w/2)-0.1, minh = 0.6*args.scale, hover = not disabled, colour = not disabled and args.colour or G.C.BLACK,shadow = not disabled, button = not disabled and 'option_cycle' or nil, ref_table = args, ref_value = 'r'}, nodes={
              {n=G.UIT.T, config={ref_table = args, ref_value = 'r', scale = args.text_scale, colour = not disabled and G.C.UI.TEXT_LIGHT or G.C.UI.TEXT_INACTIVE}}
            }},
          }}
          
        }}

  if args.cycle_shoulders then 
    t =    
    {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR}, nodes = {
      {n=G.UIT.C, config={minw = 0.7,align = "cm", colour = G.C.CLEAR,func = 'set_button_pip', focus_args = {button = 'leftshoulder', type = 'none', orientation = 'cm', scale = 0.7, offset = {x = -0.1, y = 0}}}, nodes = {}},
      {n=G.UIT.C, config={id = 'cycle_shoulders', padding = 0.1}, nodes={t}},
      {n=G.UIT.C, config={minw = 0.7,align = "cm", colour = G.C.CLEAR,func = 'set_button_pip', focus_args = {button = 'rightshoulder', type = 'none', orientation = 'cm', scale = 0.7, offset = {x = 0.1, y = 0}}}, nodes = {}},
    }}
  else
    t = 
    {n=G.UIT.R, config={align = "cm", colour = G.C.CLEAR, padding = 0.0}, nodes = {
      t
    }}
  end
  if args.label or args.info then 
    t = {n=G.UIT.R, config={align = "cm", padding = 0.05, id = args.id or nil}, nodes={
      args.label and {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.T, config={text = args.label, scale = 0.5*args.scale, colour = G.C.UI.TEXT_LIGHT}}
      }} or nil,
      t,
      info,
    }}
  end
  return t
end

function DPP.create_text_input(args)
    args = args or {}
    args.colour = copy_table(args.colour) or copy_table(G.C.BLUE)
    args.hooked_colour = copy_table(args.hooked_colour) or darken(copy_table(G.C.BLUE), 0.3)
    args.w = args.w or 2.5
    args.h = args.h or 0.7
    args.text_scale = args.text_scale or 0.4
    args.cursor_scale = args.cursor_scale or 0.4
    args.max_length = args.max_length or 16
    args.all_caps = args.all_caps or false
    args.prompt_text = args.prompt_text or ''
    args.current_prompt_text = ''
    args.id = args.id or "text_input"
    
    local suc, val = pcall(function () return string.len(args.ref_table[args.ref_value]) end)
    local text = {ref_table = args.ref_table, ref_value = args.ref_value, letters = {}, current_position = suc and val or 1}
    local ui_letters = {}
    for i = 1, args.max_length do
        text.letters[i] = (args.ref_table[args.ref_value] and (string.sub(args.ref_table[args.ref_value], i, i) or '')) or ''
        ui_letters[i] = {n=G.UIT.T, config={ref_table = text.letters, ref_value = i, scale = args.text_scale, colour = G.C.UI.TEXT_LIGHT, id = args.id..'_letter_'..i}}
    end
    args.text = text

    local position_text_colour = lighten(copy_table(G.C.BLUE), 0.4)

    ui_letters[#ui_letters+1] = {n=G.UIT.T, config={ref_table = args, ref_value = 'current_prompt_text', scale = args.text_scale, colour = lighten(copy_table(args.colour), 0.4), id = args.id..'_prompt'}}
    ui_letters[#ui_letters+1] = {n=G.UIT.B, config={r = 0.03,w=0.1, h=args.cursor_scale, colour = position_text_colour, id = args.id..'_position', func = 'flash'}}

    local t = 
        {n=G.UIT.C, config={align = "cm", colour = G.C.CLEAR}, nodes = {
            {n=G.UIT.C, config={id = args.id, align = "cm", padding = 0, r = 0.1, hover = true, colour = args.colour,minw = args.w, min_h = args.h, func = "DPP_load_text_input", button = 'select_text_input', shadow = true}, nodes={
                {n=G.UIT.R, config={ref_table = args, padding = 0.05, align = "cm", r = 0.1, colour = G.C.CLEAR}, nodes={
                {n=G.UIT.R, config={ref_table = args, align = "cm", r = 0.1, colour = G.C.CLEAR, func = 'text_input'}, nodes=
                    ui_letters
                }
                }}
            }}
            }}
    return t
end

---Replaces given characters by a specific one.
---@param s string|number|boolean -- The value to replace characters of.
---@param t table? `{{{"a","b",...},"c"},...}` A table with the characters to look for and replace with.
---@return string s The return value, as a string
function DPP.replace_text_input (s,t)
    s = tostring(s)
    t = t or {
        {{"o","O"},"0"},
        {{"d"},"."},
        {{"m"},"-"}
    }
    local ret = ""
    --print("\n---\nNEW TEST: "..s.."\n---")
    for i=1, string.len(s) do
        local char = string.sub(s,i,i)
        --print("Testing: " .. char)
        for _, v in ipairs(t) do
            for _, vv in ipairs(v[1]) do
                if char == vv then 
                    --print("Replaced: "..char.. " > ".. v[2]) 
                    char = v[2]
                end
            end
        end
        ret = ret..tostring(char)
        --print("Added: "..char.." , s: "..ret)
    end
    return ret
end

-- Ported from 'Fool's Gambit', still made by me.

---Allows to easily create multi-line texts.
---@param args {text:table|string,colour:string,scale:number,padding:number,tooltip:{}|nil,align:"tl"|"tm"|"tr"|"cl"|"cm"|"cr"|"bl"|"bm"|"br",mode:"R"|"C"} The settings for the text.
---`text = {"No text"}` is a table (array), each string represents an entire line.
---`colour = "white` is the colour of the text.<br>
---`scale = 0.3` is the size of the text.<br>
---`padding = 0.05` is the distance between lines.<br>
---`tooltip` is a tooltip that will appear when hovering over the text.<br>
---`align = "cm"` sets the alignment of the text. `l`,`m`,`r` for horizontal, `t`,`m`,`b` for vertical alignment.<br>
---`mode = "R"` sets the container alignment for rows or colums.<br>
---
---@return table node The entire node structure. Do note it has a wrapper node.
function UIText (args)
	if not args or not type(args) == "table" then return 
	{ n = G.UIT.R, nodes = {{n = G.UIT.T, config = {text = "ERROR", scale = 0.3, colour = G.C.RED}}}} end
	
	local text = args.text or {"No text"}
	local colour = args.colour or "white"
	local scale = args.scale or 0.3
	local padding = args.padding or 0.05
	local hover = args.tooltip or nil
	local align = args.align or "cm"
	local mode = args.mode or "R"
	
	local ret = {n = G.UIT[string.upper(mode)], config = {padding = padding}, nodes = {}}
	
	if type(text) ~= "table" then return ret end
	for _,text in ipairs(text) do
		local tooltip = nil

		if hover then
			tooltip = {text = {}}
			for _,h_text in ipairs(hover) do
				if h_text == "" then h_text = " " end
				table.insert(tooltip.text,h_text)
			end
		end

		local cur_txt = {n = G.UIT.R, config = {align = align, padding = 0}, nodes = {
			{n = G.UIT.T, config = { text = text, colour = G.C[string.upper(colour)], scale = scale, tooltip = tooltip, padding = 0}}
		}}
		
		table.insert(ret.nodes,cur_txt)
	end

	return ret
end

--- Custom function to make buttons:tm:
---@param args {label:{}[],vars:{},w:number|nil,h:number|nil,ref_table:table|nil,ref_value:string|nil,hover:boolean|nil,shadown:boolean|nil,colour:table|nil,text_scale:number|nil,text_col:table|nil,font:string|nil,func:string|nil,button:string|nil,type:"R"|"C"|nil}
---@return table node The button node
---`label = {{{"Word 1"},{"Word 2"}...},{"New line"}...}` - The button's label text. It is highly customizable, supporting raw text `strings`, `ref_table` + `ref_value` combinations, custom `font`, `colour` and `scale`.\
---`w = 2.7, h = 0.9` - Minimum **width** and **height** of the button.\
---`colour = G.C.RED` - Colour of the button.\
---`text_scale = 0.3` - Default text scale. Can be overwritten in each text component.\
---`text_col = G.C.WHITE` - Default text colour. Can be overwritten in each text component.\
---`font = nil` - Default font. Can be overwritten in each text component.\
---`type = C` - Defines how to align the buttons.\
---`func` - Function to run in `G.FUNCS[func]` every frame the button is present.\
---`button` - Function to run `G.FUNCS.[button]` when the button is pressed.
function UIBox_adv_button (args)
    args = args or {}
    args.label = args.label or { -- HORRID EXAMPLE ON HOW TO SET THESE UP !!!
        {
            {"ERROR"},{" NO TEXT"}
        }
    }
    args.vars = args.vars or {}
    args.w = args.w or 2.7
    args.h = args.h or 0.9
    args.ref_table = args.ref_table or nil
    args.ref_value = args.ref_value or nil
    args.hover = args.hover or true
    args.shadow = args.shadow or true
    args.colour = args.colour or G.C.RED
    args.text_scale = args.text_scale or 0.3
    args.text_col = args.text_col or G.C.WHITE
    args.font = args.font or nil
    if not args.type and (args.type ~= "R" or args.type ~= "C") then args.type = "R" end

    local texts = {}

    for _,v in ipairs(args.label) do
        local line = {n = G.UIT.R, config = {align = "cm", colour = G.C.CLEAR, minw = 0.2, minh = 0.2}, nodes = {}}
        for kk,vv in pairs(v) do
            local text = {n = G.UIT.T, config = {
                text = vv[1] or vv.string,
                ref_table = vv.ref_table,
                ref_value = vv.ref_value,
                colour = vv.colour or args.text_col or G.C.WHITE,
                scale = args.text_scale or vv.scale or 0.3,
                font = (vv.font and SMODS.Fonts[vv.font]) or (args.font and SMODS.Fonts[args.font])
            }}
            table.insert(line.nodes,text)
        end
        table.insert(texts,line)
    end

    return {n = G.UIT[args.type], config = {
      minw = args.w,
      minh = args.h,
      align = "cm",
      colour = args.colour,
      func = args.func, 
      button = args.button,
      ref_table = args.ref_table,
      ref_value = args.ref_value,
      r = 0.1,
      hover = args.hover,
      shadow = args.shadow},
      nodes = texts
    }
end

function DPP.create_checkpark(args)
  args = args or {}
  args.active_colour = args.active_colour or G.C.RED
  args.inactive_colour = args.inactive_colour or G.C.BLACK
  args.w = args.w or 3
  args.h = args.h or 0.5
  args.scale = args.scale or 1
  args.label_scale = args.label_scale or 0.4
  args.ref_table = args.ref_table or {}
  args.ref_value = args.ref_value or 'test'

  local check = Sprite(0,0,0.5*args.scale,0.5*args.scale,G.ASSET_ATLAS["icons"], {x=1, y=0})
  check.states.drag.can = false
  check.states.visible = false

  local info = nil
  if args.info then 
    info = {}
    for k, v in ipairs(args.info) do 
      table.insert(info, {n=G.UIT.R, config={align = "cm", minh = 0.05}, nodes={
        {n=G.UIT.T, config={text = v, scale = 0.25, colour = G.C.UI.TEXT_LIGHT}}
      }})
    end
    info =  {n=G.UIT.R, config={align = "cm", minh = 0.05}, nodes=info}
  end

  local t = {n=G.UIT.C, config={align = "cm", r = 0.1, padding = 0.03, minw = 0.4*args.scale, minh = 0.4*args.scale, outline_colour = G.C.WHITE, outline = 1.2*args.scale, line_emboss = 0.5*args.scale, ref_table = args,
    colour = args.inactive_colour,
    button = 'toggle_button', button_dist = 0.2, hover = true, toggle_callback = args.callback, func = 'toggle', focus_args = {funnel_to = true}}, nodes={
    {n=G.UIT.O, config={object = check}},
  }}

   if args.info then 
     t = {n=args.col and G.UIT.C or G.UIT.R, config={align = "cm"}, nodes={
       t,
       info,
     }}
   end
  return t
end