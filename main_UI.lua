DPP.test = {}
DPP.test.UI_1 = {
   content =          
   {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
      {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
         {n = G.UIT.T,config = {align = "cm", text = "DebugPlusPlus", scale = 0.4, colour = G.C.WHITE}}
      }},
      {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
         {n = G.UIT.T,config = {align = "tm", text = "Mod options", scale = 0.4, colour = G.C.WHITE}}
      }},

      {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
         {n = G.UIT.T,config = {align = "tm", text = "Background colour", scale = 0.3, colour = G.C.GREY}}
      }},
      {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
         create_option_cycle{
            options = DPP.config.background_colour.options,
            ref_table = DPP.config.background_colour,
            ref_value = "selected",
            current_option = DPP.config.background_colour.number,
            scale = 0.6,
            opt_callback = "DPP_change_menu_background",
            no_pips = true
         },
      }},
   }}}}
}

function DPP.test_UI()
   local t = DPP.test.UI_1.content

   return t
end



-- work in progress trust
function DPP._main_menu ()
   DPP.reload_lists()
   local t = {
      n = G.UIT.ROOT, config = {align = "tl", minw = 22.75, minh = 12.5, padding = 0.15, colour = G.C.CLEAR, id = "outer"}, nodes = {
         {n = G.UIT.R, config = {minw = 2, minh = 2, colour = G.C.GREEN}, nodes = {
            {n = G.UIT.O, config = {object = UIBox{
               definition = {n = G.UIT.ROOT, config = {minw = 1, minh = 1, colour = G.C.RED}},
               config = {
                     align = "cm",
                     offset = {x=0,y=0},
                     major = G.ROOM_ATTACH,
                     bond = 'Weak',
                     no_esc = false
               },
            }, id = "inner"}}
         }}
      }}
   return t
end

function DPP.main_menu ()
   DPP.reload_lists()

   local meta = {
      {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
         {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
            {n = G.UIT.T,config = {align = "cm", text = localize("dpp_name"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_cfg_label"), scale = 0.4, colour = G.C.WHITE}}
         }},

         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_cfg_background_colour"), scale = 0.3, colour = G.C.GREY}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            create_option_cycle{
               options = DPP.config.background_colour.options,
               ref_table = DPP.config.background_colour,
               ref_value = "selected",
               current_option = DPP.config.background_colour.number,
               scale = 0.6,
               opt_callback = "DPP_change_menu_background",
               no_pips = true
            },
         }},
         UIBox_button{
            label = {localize("dpp_close")},
            scale = 1,
            minw = 2, minh = 0.5
         },
         {n = G.UIT.R, config = {minh = 0.1}}
      }}}}
   }

   local card = {
      {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
         {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
            {n = G.UIT.T,config = {align = "cm", text = localize("dpp_card_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
            UIText{
               text = G.localization.misc.dictionary["dpp_card_disclaimer"],
               colour = "grey",
               scale = 0.3
            }
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_card_rank"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_option_cycle{
                  options = DPP.card.rank.options,
                  ref_table = DPP.card.rank,
                  ref_value = "selected",
                  current_option = DPP.card.rank.number,
                  scale = 0.6,
                  opt_callback = "DPP_update_rank",
                  no_pips = true
               },
               UIBox_button{
                  label = {localize("dpp_gen_apply")},
                  button = "DPP_set_rank",
                  minw = 1.6,
                  minh = 0.4,
                  scale = 0.3
               },
         }},
         
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_card_suit"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_option_cycle{
                  options = DPP.card.suit.options,
                  ref_table = DPP.card.suit,
                  ref_value = "selected",
                  current_option = DPP.card.suit.number,
                  scale = 0.6,
                  opt_callback = "DPP_update_suit",
                  no_pips = true
               },
               UIBox_button{
                  label = {localize("dpp_gen_apply")},
                  button = "DPP_set_suit",
                  minw = 1.6,
                  minh = 0.4,
                  scale = 0.3
               },
         }},
                     
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_card_enhancement"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            create_option_cycle{
                  options = DPP.card.enhancement.options,
                  ref_table = DPP.card.enhancement,
                  ref_value = "selected",
                  current_option = DPP.card.enhancement.number,
                  scale = 0.6,
                  opt_callback = "DPP_update_enhancement",
                  no_pips = true
            },
            UIBox_button{
                  label = {localize("dpp_gen_apply")},
                  button = "DPP_set_enhancement",
                  minw = 1.6,
                  minh = 0.4,
                  scale = 0.3
            },
         }},

         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_card_edition"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            create_option_cycle{
                  options = DPP.card.edition.options,
                  ref_table = DPP.card.edition,
                  ref_value = "selected",
                  current_option = DPP.card.edition.number,
                  scale = 0.6,
                  opt_callback = "DPP_update_edition",
                  no_pips = true
            },
            UIBox_button{
                  label = {localize("dpp_gen_apply")},
                  button = "DPP_set_edition",
                  minw = 1.6,
                  minh = 0.4,
                  scale = 0.3,
            },
         }},
                  
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_card_seal"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            create_option_cycle{
                  options = DPP.card.seal.options,
                  ref_table = DPP.card.seal,
                  ref_value = "selected",
                  current_option = DPP.card.seal.number,
                  scale = 0.6,
                  opt_callback = "DPP_update_seal",
                  no_pips = true
            },
            UIBox_button{
                  label = {localize("dpp_gen_apply")},
                  button = "DPP_set_seal",
                  minw = 1.6,
                  minh = 0.4,
                  scale = 0.3,
            },
         }},

         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_card_sticker"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            create_option_cycle{
               options = DPP.card.sticker.options,
               ref_table = DPP.card.suit,
               ref_value = "selected",
               current_option = DPP.card.sticker.number,
               scale = 0.6,
               opt_callback = "DPP_update_sticker",
               no_pips = true
            },
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {localize("dpp_gen_apply")},
                  button = "DPP_toggle_sticker",
                  ref_table = {false},
                  minw = 1.2,
                  minh = 0.4,
                  scale = 0.3
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {localize("dpp_gen_remove")},
                  button = "DPP_toggle_sticker",
                  ref_table = {true},
                  minw = 1.2,
                  minh = 0.4,
                  scale = 0.3
               }}},
            }},
         }},
      }}}}
   }

   local player = {
      {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
         {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
            {n = G.UIT.T,config = {align = "cm", text = localize("dpp_player_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_hand_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_slots")..": ", scale = 0.3, colour = G.C.GREY}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "hand_size"}}, scale = 0.3, colours = {G.C.GOLD}}}},

         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"hand",-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"hand",-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"hand",1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"hand",3}
            }}},
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T, config = {align = "tm", text = localize("dpp_player_highlight")..": ", scale = 0.3, colour = G.C.GREY}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "hand_highlight"}}, scale = 0.3, colours = {G.C.GOLD}}}},
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"hand",-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"hand",-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"hand",1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"hand",3}
            }}},
         }},

         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_hands_label")..": ", scale = 0.3, colour = G.C.GREY}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "hands"}}, scale = 0.3, colours = {G.C.GOLD}}}},
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
                  label = {"-3"},
                  button = "DPP_ease_hands",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
                  label = {"-1"},
                  button = "DPP_ease_hands",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
                  label = {"+1"},
                  button = "DPP_ease_hands",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
                  label = {"+3"},
                  button = "DPP_ease_hands",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {3}
            }}},
         }},
         {n = G.UIT.R, config = {align = "cm"}, nodes = {create_toggle{
            label = localize("dpp_player_unlimited"),
            ref_table = DPP.vars,
            ref_value = "unlimited_hands",
            scale = 0.5,
            w = 1, h = .5
         }}},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_discards_label")..": ", scale = 0.3, colour = G.C.GREY}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "discards"}}, scale = 0.3, colours = {G.C.GOLD}}}},
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
                  label = {"-3"},
                  button = "DPP_ease_discards",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
                  label = {"-1"},
                  button = "DPP_ease_discards",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
                  label = {"+1"},
                  button = "DPP_ease_discards",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
                  label = {"+3"},
                  button = "DPP_ease_discards",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {3}
            }}},
         }},
         {n = G.UIT.R, config = {align = "cm"}, nodes = {create_toggle{
            label = localize("dpp_player_unlimited"),
            ref_table = DPP.vars,
            ref_value = "unlimited_discards",
            scale = 0.5,
            w = 1, h = .5
         }}},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_jokers_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_slots")..": ", scale = 0.3, colour = G.C.GREY}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "joker_size"}}, scale = 0.3, colours = {G.C.GOLD}}}},
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"jokers",-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"jokers",-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"jokers",1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"jokers",3}
            }}},
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_highlight")..": ", scale = 0.3, colour = G.C.GREY}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "joker_highlight"}}, scale = 0.3, colours = {G.C.GOLD}}}},
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"jokers",-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"jokers",-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"jokers",1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"jokers",3}
            }}},
         }},
         

         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_consumable_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_slots")..": ", scale = 0.3, colour = G.C.GREY}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "consumeable_size"}}, scale = 0.3, colours = {G.C.GOLD}}}},
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"consumeables",-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"consumeables",-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"consumeables",1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_area_limit",
               ref_table = {"consumeables",3}
            }}},
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_highlight")..": ", scale = 0.3, colour = G.C.GREY}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "consumeable_highlight"}}, scale = 0.3, colours = {G.C.GOLD}}}},
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"consumeables",-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"consumeables",-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+1"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"consumeables",1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+3"},
               minw = 0.6,
               minh = 0.4,
               button = "DPP_set_highlighted_limit",
               ref_table = {"consumeables",3}
            }}},
         }},
         
         
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.5}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_money")..": ", scale = 0.4, colour = G.C.WHITE}},
            {n = G.UIT.O, config = {object = DynaText{string = {{ref_table = DPP.vars, ref_value = "dollars"}}, scale = 0.4, colours = {G.C.GOLD}}}},
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            DPP.create_text_input{
               id = "set_player_dollars",
               ref_table = DPP.run,
               ref_value = "dollars",
               prompt_text = "Input number",
               max_length = 12,
               w = 2.4,
               h = 0.2
            },
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            UIBox_adv_button{
               label = {{{localize("dpp_gen_set")}}},
               w = 1.2, h = 0.4,
               scale = 0.3,
               ref_table = {"set"},
               type = "C",
               button = "DPP_set_money"
            },
            UIBox_adv_button{
               label = {{{localize("dpp_gen_mod")}}},
               w = 1.2, h = 0.4,
               scale = 0.3,
               ref_table = {"var"},
               type = "C",
               button = "DPP_set_money"
            }
         }},
         {n = G.UIT.R, config = {align = "cm"}, nodes = {create_toggle{
            label = localize("dpp_player_unlimited"),
            ref_table = DPP.vars,
            ref_value = "unlimited_money",
            scale = 0.5,
            w = 1, h = .5
         }}},
      }}}},
   }

   local run = {
      {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
         {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
            {n = G.UIT.T,config = {align = "cm", text = localize("dpp_run_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_run_blind_label"), scale = 0.4, colour = G.C.WHITE}}
         }},

         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_run_set_blind"), scale = 0.3, colour = G.C.GREY}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            create_option_cycle{
               options = DPP.blind.options,
               ref_table = DPP.blind,
               current_option = DPP.blind.number,
               ref_value = "selected",
               opt_callback = "DPP_change_blind",
               minw = 2,
               scale = 0.6,
               no_pips = true
            }
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            UIBox_button{
               label = {localize("dpp_gen_apply")},
               button = "DPP_set_blind",
               minw = 1.8,
               minh = 0.4,
               scale = 0.3
            },
         }},

         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            UIText{
               text = {localize("dpp_run_player_chips")},
               scale = 0.3,
               colour = "grey",
               tooltip = {
                  "Symbol replacements:",
                  "o / O > 0 (zero)",
                  "d > .",
                  "m > -"
               }
            }
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            DPP.create_text_input{
               id = "set_player_chips",
               ref_table = DPP.run,
               ref_value = "chips",
               prompt_text = "Input number",
               max_length = 8,
               w = 2.4,
               h = 0.2
            }
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            UIBox_adv_button{
               label = {{{localize("dpp_gen_set")}}},
               w = 1.2, h = 0.4,
               scale = 0.3,
               ref_table = {"set"},
               type = "C",
               button = "DPP_set_chips"
            },
            UIBox_adv_button{
               label = {{{localize("dpp_gen_mod")}}},
               w = 1.2, h = 0.4,
               scale = 0.3,
               ref_table = {"var"},
               type = "C",
               button = "DPP_set_chips"
            }
         }},

         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            UIText{
               text = {localize("dpp_run_blind_chips")},
               scale = 0.3,
               colour = "grey",
               tooltip = {
                  "Symbol replacements:",
                  "o / O > 0 (zero)",
                  "d > .",
                  "m > -"
               }
            }
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
            DPP.create_text_input{
               id = "set_boss_chips",
               ref_table = DPP.run,
               ref_value = "blind_chips",
               prompt_text = "Input number",
               max_length = 8,
               w = 2.4,
               h = 0.2
            }
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            UIBox_adv_button{
               label = {{{localize("dpp_gen_set")}}},
               w = 1.2, h = 0.4,
               scale = 0.3,
               ref_table = {"set"},
               type = "C",
               button = "DPP_set_blind_chips"
            },
            UIBox_adv_button{
               label = {{{localize("dpp_gen_mod")}}},
               w = 1.2, h = 0.4,
               scale = 0.3,
               ref_table = {"var"},
               type = "C",
               button = "DPP_set_blind_chips"
            }
         }},
         
         
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_run_ante_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-3"},
               button = "DPP_set_ante",
               minw = 0.6,
               minh = 0.4,
               ref_table = {-3}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"-1"},
               button = "DPP_set_ante",
               minw = 0.6,
               minh = 0.4,
               ref_table = {-1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+1"},
               button = "DPP_set_ante",
               minw = 0.6,
               minh = 0.4,
               ref_table = {1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"+3"},
               button = "DPP_set_ante",
               minw = 0.6,
               minh = 0.4,
               ref_table = {3}
            }}},
         }}}}
      }},
   }

   local game = {
      {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
         {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
            {n = G.UIT.T,config = {align = "cm", text = localize("dpp_game_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
            {n = G.UIT.T,config = {align = "tm", text = localize("dpp_game_speed_label"), scale = 0.4, colour = G.C.WHITE}}
         }},
         {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
            DPP.create_text_input{
               id = "set_gamespeed",
               ref_table = DPP,
               ref_value = "gamespeed",
               prompt_text = "Input number",
               max_length = 8,
               w = 2.4,
               h = 0.2
            }
         }},
         {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {localize("dpp_gen_apply")},
               button = "DPP_set_gamespeed",
               minw = 1.2,
               minh = 0.4,
               scale = 0.3,
               ref_table = {1}
            }}},
            {n = G.UIT.C, nodes = { -- Horizontal tab
            UIBox_button{
               label = {"/10"},
               button = "DPP_set_gamespeed",
               minw = 1.2,
               minh = 0.4,
               scale = 0.3,
               ref_table = {10}
            }}},
         }}
      }}}}
   }

   return {
      n = G.UIT.ROOT, config = {align = "tl", minw = 22.75, minh = 13, padding = 0.15, colour = G.C.CLEAR}, nodes = {
      meta[1],
      card[1],
      player[1],
      run[1],
      game[1]
   }}
end



SMODS.current_mod.config_tab = function ()
   return { n = G.UIT.ROOT, config = {minw = 8, minh = 5, colour = G.C.CLEAR, align = "tm", padding = 0.2}, nodes = {
      {n = G.UIT.R, config = {align = "tm"}, nodes = {UIBox_button{ label = {localize("dpp_open")}, button = "DPP_main_menu", minw = 5}}},
      {n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_cfg_menu_disclaimer"), scale = 0.3, colour = G.C.WHITE}}}},
      {n = G.UIT.R, config = {align = "tm"}, nodes = {create_toggle{
         label = localize("dpp_cfg_menu_button_toggle"),
         scale = 1,
         minw = 2, minh = 0.5,
         ref_table = DPP.config,
         ref_value = "display_menu_button"
      }}}
   }}
end

SMODS.current_mod.extra_tabs = function ()
   return {
      label = localize("dpp_credits_label"),
      tab_definition_function = function ()
         return { n = G.UIT.ROOT, config = {minw = 8, minh = 5, colour = G.C.BLACK, align = "tm", padding = 0.2, r = 0.1}, nodes = {
            { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_credits_localization_label"), colour = G.C.GOLD, scale = 0.6}}}},
            { n = G.UIT.R, config = {align = "tm"}, nodes = {
               {n = G.UIT.C, config = {padding = 0.05}, nodes = {
                  { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_lan_en-us"), colour = G.C.GOLD, scale = 0.3}}}},
                  { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_lan_es_ES"), colour = G.C.GOLD, scale = 0.3}}}},
                  { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_lan_zh_CN"), colour = G.C.GOLD, scale = 0.3}}}},

               }},
               {n = G.UIT.C, config = {minw = 0.2}},
               {n = G.UIT.C, config = {padding = 0.05}, nodes = {
                  { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_names_Jogla"), colour = G.C.WHITE, scale = 0.3}}}},
                  { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_names_Jogla"), colour = G.C.WHITE, scale = 0.3}}}},
                  { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_names_GoldenLeaf"), colour = G.C.WHITE, scale = 0.3}}}},
               }},
            }},
            { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_credits_special_thanks_label"), colour = G.C.PURPLE, scale = 0.6}}}},
            { n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_names_bepisfever"), colour = G.C.WHITE, scale = 0.3}}}},
         }}
      end
   }
end