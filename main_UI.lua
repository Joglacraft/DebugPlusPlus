DPP.main_menu = function ()
   return {
      n = G.UIT.C, config = {align = "tl", minw = 22.5, minh = 12.5, padding = 0.15}, nodes = {
         
         {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
            {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
               {n = G.UIT.T,config = {align = "cm", text = "DebugPlusPlus", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Mod options", scale = 0.4, colour = G.C.WHITE}}
            }},

            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
                UIBox_button{
                    label = {"Reload lists"},
                    button = "DPP_reload_lists",
                    minw = 1.6,
                    minh = 0.4,
                    scale = 0.3
                },
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Reloads all the registered", scale = 0.2, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "card modifiers (suit, seals, etc)", scale = 0.2, colour = G.C.GREY}}
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
                  opt_callback = "DPP_change_menu_background"
               },
            }},
         }}}},
         
         {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
            {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
               {n = G.UIT.T,config = {align = "cm", text = "Card", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "(Applies to selected cards)", scale = 0.2, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Rank", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
                create_option_cycle{
                    options = DPP.card.rank.options,
                    ref_table = DPP.card.rank,
                    ref_value = "selected",
                    current_option = DPP.card.rank.number,
                    scale = 0.6,
                    opt_callback = "DPP_update_rank"
                },
                UIBox_button{
                    label = {"Apply"},
                    button = "DPP_set_rank",
                    minw = 1.6,
                    minh = 0.4,
                    scale = 0.3
                },
            }},
            
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Suit", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
                create_option_cycle{
                    options = DPP.card.suit.options,
                    ref_table = DPP.card.suit,
                    ref_value = "selected",
                    current_option = DPP.card.suit.number,
                    scale = 0.6,
                    opt_callback = "DPP_update_suit"
                },
                UIBox_button{
                    label = {"Apply"},
                    button = "DPP_set_suit",
                    minw = 1.6,
                    minh = 0.4,
                    scale = 0.3
                },
            }},
                        
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Enhancement", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_option_cycle{
                    options = DPP.card.enhancement.options,
                    ref_table = DPP.card.enhancement,
                    ref_value = "selected",
                    current_option = DPP.card.enhancement.number,
                    scale = 0.6,
                    opt_callback = "DPP_update_enhancement"
               },
               UIBox_button{
                    label = {"Apply"},
                    button = "DPP_set_enhancement",
                    minw = 1.6,
                    minh = 0.4,
                    scale = 0.3
               },
            }},
                        
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Edition", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_option_cycle{
                    options = DPP.card.edition.options,
                    ref_table = DPP.card.edition,
                    ref_value = "selected",
                    current_option = DPP.card.edition.number,
                    scale = 0.6,
                    opt_callback = "DPP_update_edition"
               },
               UIBox_button{
                    label = {"Apply"},
                    button = "DPP_set_edition",
                    minw = 1.6,
                    minh = 0.4,
                    scale = 0.3,
               },
            }},
                    
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Seal", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_option_cycle{
                    options = DPP.card.seal.options,
                    ref_table = DPP.card.seal,
                    ref_value = "selected",
                    current_option = DPP.card.seal.number,
                    scale = 0.6,
                    opt_callback = "DPP_update_seal"
               },
               UIBox_button{
                    label = {"Apply"},
                    button = "DPP_set_seal",
                    minw = 1.6,
                    minh = 0.4,
                    scale = 0.3,
               },
            }},

            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "(To create cards, ", scale = 0.3, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "open the collection.", scale = 0.3, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Then press [3] when", scale = 0.3, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "hovering over a card)", scale = 0.3, colour = G.C.GREY}}
            }},
         }}}},


         {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
            {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
               {n = G.UIT.T,config = {align = "cm", text = "Player", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Hand", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Size", scale = 0.3, colour = G.C.GREY}}
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
               {n = G.UIT.T,config = {align = "tm", text = "Hands", scale = 0.3, colour = G.C.GREY}}
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
            --[[{n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_toggle{
                  label = "Unlimited hands",
                  w = 1.4,
                  h = 0.4,
                  scale = 0.6,
               }
            }},]]

            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Discards", scale = 0.3, colour = G.C.GREY}}
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
            --[[{n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_toggle{
                  label = "Unlimited discards",
                  w = 1.4,
                  h = 0.4,
                  scale = 0.6,
               }
            }},]]

            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Jokers", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Slots", scale = 0.3, colour = G.C.GREY}}
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
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Sticker", scale = 0.3, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.3}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "(Applies to selected cards)", scale = 0.2, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_option_cycle{
                  options = DPP.card.sticker.options,
                  ref_table = DPP.card.suit,
                  ref_value = "selected",
                  current_option = DPP.card.sticker.number,
                  scale = 0.6,
                  opt_callback = "DPP_update_sticker"
               },
               {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"Rmv"},
                  button = "DPP_remove_sticker",
                  minw = 1.2,
                  minh = 0.4
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"Add"},
                  button = "DPP_add_sticker",
                  minw = 1.2,
                  minh = 0.4
               }}},
            }},
            }},

            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Consumeables", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Slots", scale = 0.3, colour = G.C.GREY}}
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
            
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Money", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-5"},
                  minw = 0.6,
                  minh = 0.4,
                  button = "DPP_set_money",
                  ref_table = {-5}
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-1"},
                  minw = 0.6,
                  minh = 0.4,
                  button = "DPP_set_money",
                  ref_table = {-1}
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+1"},
                  minw = 0.6,
                  minh = 0.4,
                  button = "DPP_set_money",
                  ref_table = {1}
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+5"},
                  minw = 0.6,
                  minh = 0.4,
                  button = "DPP_set_money",
                  ref_table = {5}
               }}},
            }},
         }}}},

         {n = G.UIT.C, nodes = {{n = G.UIT.C, config = {align = "tm", colour = G.C[DPP.config.background_colour.selected], padding = 0.05, outline = 1, outline_colour = G.C.WHITE, r = 0.15}, nodes = { -- Tab
            {n = G.UIT.R, config = {align = "cm", minw = DPP.config.big_menu_width, minh = 0.5, colour = G.C.RED, r = 0.15, padding = 0.1}, nodes = { -- Title
               {n = G.UIT.T,config = {align = "cm", text = "Run", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Blind", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Player Chips", scale = 0.3, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {

            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+1"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+10"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+100"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+1.000"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+10.000"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-1"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-10"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-100"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-1.000"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-10.000"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
            }},
            }},

            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.1}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Required chips", scale = 0.3, colour = G.C.GREY}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+1"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+10"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+100"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+1.000"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+10.000"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-1"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-10"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-100"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-1.000"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-10.000"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
            }},
            }},

            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               create_option_cycle{
                  options = {"Unavailable"},
                  ref_table = DPP.blind,
                  ref_value = "selected",
                  minw = 2,
                  scale = 0.6,
                  colour = G.C.GREY
               }
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               UIBox_button{
                  label = {"Apply"},
                  colour = G.C.GREY,
                  minw = 1.8,
                  minh = 0.4,
                  scale = 0.4
               },
            }},
            
            {n = G.UIT.R, config = {align = "cm", minw = 2, minh = 0.2}, nodes = {
               {n = G.UIT.T,config = {align = "tm", text = "Ante", scale = 0.4, colour = G.C.WHITE}}
            }},
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
            {n = G.UIT.R, config = {padding = 0.05, align = "tm"}, nodes = { -- Vertical buttons
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-3"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"-1"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+1"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
               {n = G.UIT.C, nodes = { -- Horizontal tab
               UIBox_button{
                  label = {"+3"},
                  minw = 0.6,
                  minh = 0.4,
                  colour = G.C.GREY
               }}},
            }},
            }},
         }}}}
      }
   }
end
