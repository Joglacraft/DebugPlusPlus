Debug Plus Plus is a mod for **Balatro** that is meant to ease some common actions when debugging and creating mods. To open and close the main UI, press [TAB] or use the button in the pause menu. (This can be changed in the mod's settings menu)  

![](/assets/other/screenshot_1.png)
![](/assets/other/dropdown.png)
![](/assets/other/inspector.png)

> [!Important]
>
> Requires [Steamodded](https://github.com/Steamodded/smods) >1.0.0 to work.  
> This mod is meant to be used in conjunction with [DebugPlus](https://github.com/WilsontheWolf/DebugPlus).
> It is discouraged to use this mod in a multiplayer/competitive setting. I am not held responsible in any way for any misuse of the mod.

# Features

- A user-friendly UI to access the mod's main functions.
- Modify card properties, rank, suit, edition, enhancement (for playing cards), seal and stickers.
- Modify any card data at will via the 'card inspector'.
- Change maximum and maximum highlighted slots for cards, jokers and consumeables.
- Draw cards anywhere (buggy when used outside blinds).
- Change player's stats (Hands, Discards, Money).
- Modify Poker hands' levels, chips and mult individually.
- Set Player and blind's chips.
- Set boss blind (both to a random one or a choosen one).
- Win and lose run.
- Win blind.
- Set game speed.
- Save, load and remove as many savestates as you will. These are saved between profiles. DebugPlus Savestates are not listed.
- Some UI customization.
- Dismiss button for the gameover screen.
- Compatibility with Talisman.

# FAQ

**How do I open and close the menu?**\
Press [TAB] while in-game, or use the 'DebugPlusPlus' button in the pause menu. (Can be toggled in the mod settings menu).

**DebugPlus' menu gets stuck when I release [TAB].**\
Hold [TAB] for around 0.2 seconds when opening and closing the menu.

**There is a weird green box blocking the right side of the screen.**\
Same as above. This is due to a weird interaction with DebugPlus and DebugPlusPlus (this mod).

**I cannot change certain card data**\
This is likely because the game is actively changing it back. DebugPlusPlus can't help you in this case.

**I found a bug/want to suggest a feature.**\
Report/suggest it inside the [dedicated thread](https://discord.com/channels/1116389027176787968/1372508275794513962) in the offical Balatro's discord server.\

**How do I use the card inspector**\
The card inspector can be enabled in the 'card' tab. After being selected, selecting cards will generate a UI attached to them.
> [!NOTE]
> Previously highlighted cards won't be affected. De-select and re-select them for the inspector to appear.

Use the '<' and '>' buttons to navigate through the list. It will display 5 entries per page.\
For each element, it will display to the left the variable type, the key and the value.\
Use the 'Back' button to return to the parent table. The 'root' of the card will be the card object itself.\
Use the '+' button to add a new variable. A menu will pop up with 2 input fields: The name of the variable, and the value.
For the value, it can be set as a string, a number (if it can be converted to a number using cryptid's 'to_big' or lua's standard 'tonumber' as a fallback, a boolean, defaulting false unless the value is exactly `true`, or a table, in which case the value is discarded.

**The game crashes after I change a number in the card inspector**\
This is because DebugPlusPlus is stringifying said number, thus it attemps to do an operation with a string when expecting a number.\
To solve this issue, use the button to the left of the key instead. It will prompt with a UI similar to the one used to create new variables.

# Settings
- **Add DebugPlusPlus pause menu button** - Adds a new button to the pause menu (both in a run and in the main menu) to quickly access DebugPlusPlus.
- **Require to hold Ctrl too to toggle the menu** - Makes so the DebugPusPlus interface can only be toggled while pressing both [TAB] and [CONTROL] at the same time.
- **Open original Debug menu** - Prevents the vanilla debug menu from appearing while holding [TAB]. Useful if you want to only use the DebugPlusPlus menu and want to avoid any interactions with the original debug menu. Other debug functions are kept intact.
- **Override overlay menu** - Weather the DebugPlusPlus menu should override already existing overlay menus. It is recommended to keep this setting enabled and not toggle the menu when another overlay is present.
