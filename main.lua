
DPP = {
   TABS = {},
   local_config = {
      is_open = false
   },
   -- config values in the config file
   set_blind_number = "1",
   card = {
      rank = {
         options = {},
         selected = "Ace",
         number = 1
      },
      suit = {
         options = {},
         selected = "Spades",
         number = 1,
      },
      enhancement = {
         options = {"None"},
         key = {"c_base"},
         selected = "None",
         value = "None",
         number = 1,
      },
      edition = {
         options = {none = nil},
         key = {nil},
         selected = "None",
         number = 1,
      },
      seal = {
         options = {"None"},
         selected = "None",
         number =1
      },
      sticker = {
         options = {"None"},
         selected = "None",
         number = 1,
      }
   },
   blind = {
      options = {"Random"},
      key = {nil},
      selected = "Random",
      number = 1
   },
   run = {
      chips = 0,
      blind_chips = 0
   },
   gamespeed = 1
}


-- Load mod files
DPP.config = SMODS.current_mod.config
local files = {
   "callback_functions",
   "aux_functions",
   "main_UI"
}





for k, v in pairs(files) do -- Load this mod's files
	assert(SMODS.load_file('/'..v..'.lua'))()
end

DPP.reload_lists()
DPP.reload_default_values()





SMODS.Keybind({
    key_pressed = "tab",
    event = "pressed",
    action = function()
      if not DPP.local_config.is_open or not G.OVERLAY_MENU then
         G.FUNCS.DPP_main_menu()
         DPP.local_config.is_open = true
      elseif DPP.local_config.is_open then
         G.FUNCS.exit_overlay_menu()
         DPP.local_config.is_open = false
      end
   end
})