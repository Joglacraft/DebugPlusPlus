
DPP = {
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
   }
}


-- Load mod files
DPP.config = SMODS.current_mod.config
local files = {
   "callback_functions",
   "main_UI",
   "aux_functions"
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
            G.FUNCS.DPP_main_menu()
    end
})

