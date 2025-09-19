
DPP = {
   TABS = {},
   libs = {},
   local_config = {
      is_open = false
   },
   -- config values in the config file
   set_blind_number = "1",
   card = {
      rank = {
         options = {},
         page = 1,
         func = 'rank'
      },
      suit = {
         options = {},
         page = 1,
         func = 'suit'
      },
      enhancement = {
         options = {"None"},
         page = 1,
         func = 'enhancement'
      },
      edition = {
         options = {none = nil},
         page = 1,
         func = 'edition'
      },
      seal = {
         options = {"None"},
         page = 1,
         func = 'seal'
      },
      sticker = {
         options = {"None"},
         page = 1,
         func = 'sticker'
      }
   },
   blind = {
      options = {"Random"},
      page = 1,
      func = 'blind'
   },
   run = {
      chips = 0,
      blind_chips = 0,
      dollars = 0,
   },
   gamespeed = 1,
   menu_width = 3,
   vars = {
      pages = {
         meta = 1,
         card = 1,
         player = 1,
         run = 1,
         game = 1,
      },
      enable_card_inspector = false
      -- Some are filled out in overrides.lua
   },
   keys = {}
}

SMODS.Atlas{key = "modicon", path = "modicon.png", px = 32, py = 32}


-- Load mod files
DPP.config = SMODS.current_mod.config
local files = {
   "callback_functions",
   "aux_functions",
   "overrides",
   "main_UI"
}

for k, v in pairs(files) do -- Load this mod's files
	assert(SMODS.load_file('/'..v..'.lua'))()
end

DPP.reload_lists()


create_UIBox_debug_tools()


SMODS.Keybind({
   key_pressed = "tab",
   event = "pressed",
   action = function()
      if DPP.config.require_ctrl and not DPP.keys.lctrl then return end
      if not DPP.local_config.is_open or not G.OVERLAY_MENU then
         G.FUNCS.DPP_main_menu()
         DPP.local_config.is_open = true
      elseif DPP.local_config.is_open then
         G.FUNCS.exit_overlay_menu()
         DPP.local_config.is_open = false
      end
   end,
})

SMODS.Keybind({
   key_pressed = "lctrl",
   event = "pressed",
   action = function()
      DPP.keys.lctrl = true
   end,
})

SMODS.Keybind({
   key_pressed = "lctrl",
   event = "released",
   action = function()
      DPP.keys.lctrl = false
   end,
})