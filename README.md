Star Cards Project Outline
Designer/Developers: Ryan Culbertson-Faegre and Jack Hacker and Nick Lombardi
Created with: Godot 3
Game Genre: CCG RTS Roguelite

#### Known bugs:

Pressing a location's menu buttons causes movement.

When moving away from a location, doing it all at once makes the menu disappear, which is expected. What is unexpected, is that moving away from the location in small increments results in the menu staying present, disappearing during subsequent movement, and then reappearing again no matter how far away the player is. The menu keeps showing up until another menu location is displayed, at which point the problem stops.

When two delivery quests may be completed at the same location, or a delivery quest may be started at the same location which another delivery quest may be completed, completing the first (higher in list) quest will cause the second delivery to show up twice when the menu is reopened. If the higher of these two options is selected, there will still be one left when the location is revisited. If the lower is selected, they will both disappear.