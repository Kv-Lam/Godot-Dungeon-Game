# Dungeons of Delgrhiard
## Overview:
This is an isometric dungeon game with a turn-based combat system made in Godot using GDScript by Sean Sullivan, Kevin Lam, David Cheves, and Minh Cao.

## How to run the game
1. Install GoDot (We used version 4.3).
2. Open this project with GoDot.
3. To play, press Run Project on the top right of the screen or press F5.

## How to play the game:
1. Controls are WASD by default to walk around. If needed, you are able to change your controls in the main menu's options tab.
3. Pressing 'I' will access your inventory (Only a UI pops up, as the functionality was never finished by David. Keybind was also never added to the options menu by Kevin because inventory was a late implementation).
4. Holding 'Left Shift' will make you sprint.
5. Press New Game to start (Load Game and load system was never connected by David).
6. Explore the dungeon and encounter enemies.
7. To initiate combat, run into an enemy.
8. In the fight scene you have 4 options: Fight, Guard, Inventory, and Escape.
9. Fight will allow you to select an enemy as a target to attack. The damage is based on the character's ATK and enemy's DEF. Currently only does basic attacks as Minh never implemented abilities.
10. Guard will allow you to raise your defense by 20% until the character's next turn
11. Inventory not fully implemented yet.
12. Escape will give you a 50% + (character's dodge stat / 10)% to escape
13. Keep going until you find the final boss (Skeleton King) and win by defeating him.
14. No winning screen yet, just bragging rights.
15. If you get wiped, you do get a "Game Over" screen.

## Contributions
### Sean Sullivan: Almost all the art (inventory UI was not his, but everything else and the items were), moving through rooms, and creating the actual room scenes.
### Kevin Lam: All of the combat system, main menu, options menu, saving/loading options, enemies, party management (very little) and player movement and collision. Some character variables for combat.
### David Cheves: 
### Minh Cao: 
