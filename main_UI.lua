local function create_title (args)
   args.loc_title = args.loc_title or "dpp_name"
   args.area = args.area or nil
   args.pages = args.pages or 1

   return
   {n = G.UIT.R, config = {align = "tm", colour = G.C.CLEAR, r = 0}, nodes = { -- Title
      UIBox_adv_button{
         label = {{{"<"}}},
         type = "C",
         w = 0.4, h = 0.4,
         ref_table = {args.area,-1},
         button = (args.pages > 1 and "DPP_reload_lists") or nil,
         colour = (args.pages <= 1 and G.C.UI.TEXT_INACTIVE) or nil,
      },
      {n = G.UIT.C, config = {align = "cm", minw = DPP.menu_width-1, minh = 0.5, colour = G.C.RED, r = 0.15}, nodes = { -- Title
         UIText{
            text = {localize(args.loc_title)},
            scale = 0.4,
            mode = "C"
         },
      }},
      UIBox_adv_button{
         label = {{{">"}}},
         type = "C",
         w = 0.4, h = 0.4,
         ref_table = {args.area,1},
         button = (args.pages > 1 and "DPP_reload_lists") or nil,
         colour = (args.pages <= 1 and G.C.UI.TEXT_INACTIVE) or nil
      },
   }}
   
end


function DPP.main_menu ()
   DPP.reload_lists()

   local tabs = {
      {key = "meta", value = {
         {
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = localize("dpp_meta_background_colour"), scale = 0.3, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               DPP.create_option_cycle{
                  options = DPP.config.background_colour.options,
                  ref_table = DPP.config.background_colour,
                  ref_value = "selected",
                  current_option = DPP.config.background_colour.number,
                  scale = 0.7,
                  w = 4,
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

         }
      }},
      {key = "card", value = {
         {
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               UIText{
                  text = G.localization.misc.dictionary["dpp_card_disclaimer"],
                  colour = "grey",
                  scale = 0.3
               }
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_adv_button{
                  label = {{{localize("dpp_card_rank")}}},
                  w = 2.5,
                  h = 0.4,
                  scale = 0.3,
                  type = "C",
                  button = "DPP_dropdown_tab",
                  ref_table = {page = 1, type = DPP.card['rank']}
               },
            }},
            
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_adv_button{
                  label = {{{localize("dpp_card_suit")}}},
                  w = 2.5,
                  h = 0.4,
                  scale = 0.3,
                  type = "C",
                  button = "DPP_dropdown_tab",
                  ref_table = {page = 1, type = DPP.card['suit']}
               },
            }},
                        
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_adv_button{
                  label = {{{localize("dpp_card_enhancement")}}},
                  w = 2.5,
                  h = 0.4,
                  scale = 0.3,
                  type = "C",
                  button = "DPP_dropdown_tab",
                  ref_table = {page = 1, type = DPP.card['enhancement']}
               },
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_adv_button{
                  label = {{{localize("dpp_card_edition")}}},
                  w = 2.5,
                  h = 0.4,
                  scale = 0.3,
                  type = "C",
                  button = "DPP_dropdown_tab",
                  ref_table = {page = 1, type = DPP.card['edition']}
               },
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_adv_button{
                  label = {{{localize("dpp_card_seal")}}},
                  w = 2.5,
                  h = 0.4,
                  scale = 0.3,
                  type = "C",
                  button = "DPP_dropdown_tab",
                  ref_table = {page = 1, type = DPP.card['seal']}
               },
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_adv_button{
                  label = {{{localize("dpp_card_sticker")}}},
                  w = 2.5,
                  h = 0.4,
                  scale = 0.3,
                  type = "C",
                  button = "DPP_dropdown_tab",
                  ref_table = {page = 1, type = DPP.card['sticker']}
               },
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_toggle{
                  label = 'Inspector',
                  ref_table = DPP.vars,
                  ref_value = 'enable_card_inspector',
                  scale = 0.5,
                  w = 1, h = .5
               }
            }},
         },
      }},
      {key = "player", value = {
         {
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_hand_label"), scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_slots")..": ", scale = 0.3, colour = G.C.GREY}},
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "hand_size", scale = 0.3, colour = G.C.GOLD}},
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
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "hand_highlight", scale = 0.3, colour = G.C.GOLD}},
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
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "hands", scale = 0.3, colour = G.C.GOLD}},
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
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "discards", scale = 0.3, colour = G.C.GOLD}},
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
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "joker_size", scale = 0.3, colour = G.C.GOLD}},
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
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "joker_highlight", scale = 0.3, colour = G.C.GOLD}},
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
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "consumeable_size", scale = 0.3, colour = G.C.GOLD}},
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
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "consumeable_highlight", scale = 0.3, colour = G.C.GOLD}},
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
         },
         {
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.5}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = localize("dpp_player_money")..": ", scale = 0.4, colour = G.C.WHITE}},
               {n = G.UIT.T, config = {ref_table = DPP.vars, ref_value = "dollars", scale = 0.4, colour = G.C.GOLD}},
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
         },
      }},
      {key = "run", value = {
         {
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = localize("dpp_run_blind_label"), scale = 0.4, colour = G.C.WHITE}}
            }},

            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_adv_button{
                  label = {{{localize("dpp_run_set_blind")}}},
                  w = 2.5,
                  h = 0.4,
                  scale = 0.3,
                  type = "C",
                  button = "DPP_dropdown_tab",
                  ref_table = {type =  DPP['blind']}
               },
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_button{
                  label = {localize("dpp_run_win_blind")},
                  button = "DT_win_blind",
                  minw = 2.5,
                  minh = 0.4,
                  scale = 0.3
               },
            }},

            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               UIText{
                  text = {localize("dpp_run_player_chips")},
                  scale = 0.3,
                  colour = "grey",
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
            }},

            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = localize("dpp_run_round_label"), scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-3"},
                  button = "DPP_set_round",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {-3}
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-1"},
                  button = "DPP_set_round",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {-1}
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+1"},
                  button = "DPP_set_round",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {1}
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+3"},
                  button = "DPP_set_round",
                  minw = 0.6,
                  minh = 0.4,
                  ref_table = {3}
               }}},
            }},

            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
                  {n = G.UIT.C, nodes = { -- Horizontal tab
                  UIBox_button{
                     label = {localize("dpp_run_lose_label")},
                     button = "DT_lose_game",
                     minw = 1.2,
                     minh = 0.4,
                     scale = 0.3
                  }}},
                  {n = G.UIT.C, nodes = { -- Horizontal tab
                  UIBox_button{
                     label = {localize("dpp_run_win_label")},
                     button = "DT_win_game",
                     minw = 1.2,
                     minh = 0.4,
                     scale = 0.3,
                     trim = {1, 10}
                  }}},
               }},
            }},
         }
      }},
      {key = "game", value = {
         {
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
         }
      }}
   }

   for i,v in ipairs(tabs) do
      if DPP.vars.pages[v.key] <= 0 then DPP.vars.pages[v.key] = #v.value end
      if DPP.vars.pages[v.key] > #v.value then DPP.vars.pages[v.key] = 1 end
   end

   t = {}
   for i,v in ipairs(tabs) do
      t[#t+1] = 
         {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
         create_title {
               loc_title = "dpp_"..v.key.."_label",
               area = v.key,
               pages = #v.value
         },
         {n = G.UIT.R, config = {align = "cm"}, nodes = v.value[DPP.vars.pages[v.key]]},
         }}}}
   end

   return {
      n = G.UIT.ROOT, config = {align = "tl", minw = 22.75, minh = 13, padding = 0.15, colour = G.C.CLEAR}, nodes = t}
end

function DPP.dropdown_tab (args)
   args = args or {}
   args.type = args.type or DPP.card.enhancement
   args.page = args.page or args.type['page'] or 1

   DPP.local_config.is_open = false

   local t = {}
   
   local colums = args.c or 2
   local rows = args.r or 8

   local max_pages = math.ceil(#args.type['options']/(colums*rows))

   args.type['page'] = args.page

   if args.type['page'] < 1 then args.type['page'] = max_pages end
   if args.type['page'] > max_pages then args.type['page'] = 1 end

   args.page = args.type['page'] or 1

   local max_length = 20

   for i=colums*(args.page-1)+1, colums*(args.page) do -- The first i is the current colum
      local c = {}
      for ii = 1, rows do -- The second ii is the entry in the column. Use `rows*(i-1))+ii` to get the current entry
         local entry = args.type['options'][(rows*(i-1))+ii]
         if not entry then break end
         if string.len(entry) > max_length then entry = string.sub(entry,1,max_length).."..." end
         c[#c+1] = UIBox_adv_button{
            label = {{{entry}}},
            colour = G.C.RED,
            text_scale = 0.4,
            w = 4.25, h = 0.5,
            button = "DPP_set_"..args.type.func,
            ref_table = {entry},
         }
      end
      t[#t+1] = {n = G.UIT.C, config = {align = "tm", padding = 0.1}, nodes = c}
   end

   local page_cycler = {n = G.UIT.C, config = {align = "cm", padding = 0.1}, nodes = {
      {n = G.UIT.C, config = {hover = true, shadow = true, button = (max_pages > 1 and "DPP_dropdown_tab") or nil, ref_table = {type = args.type, page = args.page - 1}, align = "cm", r = 0.1, minw = 0.4, minh = 0.6, colour = (max_pages > 1 and G.C.BLUE) or G.C.GREY}, nodes = {{emboss = 0.1, n = G.UIT.T, config = {align = "cm", text = "<", scale = 0.5, colour = G.C.WHITE}}}},
      {n = G.UIT.C, config = {hover = true, shadow = true, align = "cm", r = 0.1, minw = 2, minh = 0.6, colour = G.C.BLUE}, nodes = {
         {n = G.UIT.T, config = {emboss = 0.1, align = "cm", text = "Page ", scale = 0.5, colour = G.C.WHITE}},
         {n = G.UIT.T, config = {emboss = 0.1, align = "cm", ref_table = args.type, ref_value = "page", scale = 0.5, colour = G.C.WHITE}},
         {n = G.UIT.T, config = {emboss = 0.1, align = "cm", text = "/"..max_pages, scale = 0.5, colour = G.C.WHITE}},
      }},
      {n = G.UIT.C, config = {hover = true, shadow = true, button = (max_pages > 1 and "DPP_dropdown_tab") or nil, ref_table = {type = args.type, page = args.page + 1}, align = "cm", r = 0.1, minw = 0.4, minh = 0.6, colour = (max_pages > 1 and G.C.BLUE) or G.C.GREY}, nodes = {{emboss = 0.1, n = G.UIT.T, config = {align = "cm", text = ">", scale = 0.5, colour = G.C.WHITE}}}},
   }}

   local entries_label = {n = G.UIT.T, config = {align = "cm", text = "Total entries: "..#args.type['options'], scale = 0.5, colour = G.C.WHITE}}


   return {n = G.UIT.ROOT, config = {colour = G.C[DPP.config.background_colour.selected], align = "cm", padding = 0.2, r = 0.1, outline = 1, outline_colour = G.C.WHITE}, nodes = {
      --{n = G.UIT.R, config = {align = "cm"}, nodes = {
         {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {UIText{text={args.type.func or "enhancement"},align = "cm", scale = 0.7}}},
         {n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {page_cycler}},
         {n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = {entries_label}},
      --}},
      {n = G.UIT.R, config = {align = "cm", minw = 3, minh = 5}, nodes = {{padding = 0, n = G.UIT.R, align = {"cm"}, nodes = t}}},
      UIBox_adv_button{
         label = {{{"Cancel"}}},
         colour = G.C.ORANGE,
         text_scale = 0.5,
         w = 5, h = 0.6,
         button = "DPP_main_menu"
      },
   }}
end

function DPP.card_inspector_UI (card,path,page)
   path = path or {}
   page = page or 0

   local t = {}
   local i = 0
   local max_entries = 5
   local total_entries = 0

   

   local ret = card
   for _, key in ipairs(path) do
      ret = ret and ret[key]
      if ret == nil then break end
   end
   table.sort(ret)

   for _,_ in pairs(ret) do total_entries = total_entries + 1 end

   for k,v in pairs(ret) do
      i = i + 1
      --print(i)
      if i > max_entries*page and i < (max_entries*(page+1))+1 then
         t[#t+1] = {n = G.UIT.R, config = {align = "cm"}, nodes = {
            {n = G.UIT.C, config = {align = "cm"}, nodes = {{n = G.UIT.T, config = {text = tostring(k)..": ", scale = 0.3, colour = G.C.WHITE}}}},
            {n = G.UIT.C, config = {align = "cm"}, nodes = {
               ( type(v) == "boolean" and DPP.create_checkpark{
                  scale = 0.7,
                  ref_table = ret,
                  ref_value = k,
               } or (type(v) == "string" or type(v) == "number") and DPP.create_text_input{
                  id = tostring(i).."_input",
                  ref_table = ret,
                  ref_value = k,
                  w = 1,
                  h = 0,
                  text_scale = 0.3,
                  cursor_scale = 0.3,
                  max_length = 64,
               } or UIBox_button{
                  label = {"Table"},
                  minw = 0.8,
                  minh = 0.4,
                  button = "DPP_reload_inspector_ui",
                  ref_table = {card = card, target = k, path = path}
               } or {n = G.UIT.T, config = {text = tostring(v), scale = 0.3, colour = G.C.WHITE}})
            }}
         }}
      end
   end
   --[[
      print("----")
      print(max_entries*page)
      print(max_entries*(page+1))
      print("----")
   ]]
   local path_string = "card"
   if #path <= 3 then
      for i=1, #path do
         path_string = path_string.."/"..path[i]
      end
   else
      path_string = path_string.."/.../"..path[#path-1].."/"..path[#path]
   end

   local c = {
      {n = G.UIT.R, config = {align = "cm"}, nodes = {
         {n = G.UIT.T, config = {text = path_string, scale = 0.3, colour = G.C.WHITE}}
      }},
      {n = G.UIT.R, config = {align = "cm"}, nodes = {
         {n = G.UIT.T, config = {text = localize("k_page").." "..page+1 .."/"..(math.ceil(total_entries/max_entries)), scale = 0.3, colour = G.C.WHITE}}
      }},
      {n = G.UIT.R, config = {align = "cm", minh = 0.1}},
      {n = G.UIT.R, config = {align = "cm"}, nodes = {
         {n = G.UIT.C, config = {align = "cm"}, nodes = {
         UIBox_button{
            label = {localize("b_back")},
            minw = 0.8,
            minh = 0.4,
            scale = 0.3,
            button = (#path > 0 and "DPP_reload_inspector_ui") or nil,
            colour = (#path > 0 and G.C.RED) or G.C.GREY,
            ref_table = {card = card, target = false, path = path}
         }}},
         {n = G.UIT.C, config = {align = "cm"}, nodes = {
         UIBox_button{
            label = {"<"},
            minw = 0.8,
            minh = 0.4,
            scale = 0.3,
            button = (page > 0 and "DPP_reload_inspector_ui") or nil,
            colour = (page > 0 and G.C.RED) or G.C.GREY,
            ref_table = {card = card, path = path, page = page-1}
         }}},
         {n = G.UIT.C, config = {align = "cm"}, nodes = {
         UIBox_button{
            label = {">"},
            minw = 0.8,
            minh = 0.4,
            scale = 0.3,
            button = (page < (math.ceil(total_entries/max_entries)-1) and "DPP_reload_inspector_ui") or nil,
            colour = (page < (math.ceil(total_entries/max_entries)-1) and G.C.RED) or G.C.GREY,
            ref_table = {card = card, path = path, page = page + 1}
         }}},
      }}
   }

   return {n = G.UIT.ROOT, config = {minw = 2, minh = 2, colour = G.C.BLACK, align = "tm", r = 0.1, outline = 1, outline_colour = G.C.WHITE, padding = 0.1}, nodes = {
      (not card.playing_card and {n = G.UIT.R, config = {align = "cm"}, nodes = c}) or nil,
      {n = G.UIT.R, config = {align = "cm", padding = 0.1}, nodes = t},
      (card.playing_card and {n = G.UIT.R, config = {align = "cm"}, nodes = c} or nil)
   }}
end

SMODS.current_mod.config_tab = function ()
   return { n = G.UIT.ROOT, config = {minw = 8, minh = 5, colour = G.C.CLEAR, align = "tm", padding = 0.2}, nodes = {
      {n = G.UIT.R, config = {align = "tm"}, nodes = {UIBox_button{ label = {localize("dpp_open")}, button = "DPP_main_menu", minw = 5}}},
      {n = G.UIT.R, config = {align = "tm"}, nodes = {{n = G.UIT.T, config = {text = localize("dpp_meta_menu_disclaimer"), scale = 0.3, colour = G.C.WHITE}}}},
      {n = G.UIT.R, config = {align = "tm"}, nodes = {create_toggle{
         label = localize("dpp_meta_menu_button_toggle"),
         scale = 1,
         minw = 2, minh = 0.5,
         ref_table = DPP.config,
         ref_value = "display_menu_button"
      }}},
      {n = G.UIT.R, config = {align = "tm"}, nodes = {create_toggle{
         label = localize("dpp_meta_require_ctrl"),
         scale = 1,
         minw = 2, minh = 0.5,
         ref_table = DPP.config,
         ref_value = "require_ctrl"
      }}},
      {n = G.UIT.R, config = {align = "tm"}, nodes = {create_toggle{
         label = localize("dpp_meta_open_og_debug"),
         scale = 1,
         minw = 2, minh = 0.5,
         ref_table = DPP.config,
         ref_value = "open_og_debug"
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