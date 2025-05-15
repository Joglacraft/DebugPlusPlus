
DPP = {
   test = {
      a = {},
      b = ""
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
   }
}

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
   DPP.blind.key = {nil}
   for _,v in pairs(SMODS.Blinds) do
      DPP.blind.options[#DPP.blind.options+1] = v.name
      DPP.blind.key[#DPP.blind.key+1] = v.key
   end
end
-- Load mod files
DPP.config = SMODS.current_mod.config
local files = {
   "callback_functions",
   "main_UI",
   "aux_functions"
}

DPP.reload_lists()

for k, v in pairs(files) do -- Load this mod's files
	assert(SMODS.load_file('/'..v..'.lua'))()
end

SMODS.Keybind({
    key_pressed = "tab",
    event = "pressed",
    action = function()
            G.FUNCS.DPP_main_menu()
    end
})

