Star Cards Project Outline
Designer/Developers: Ryan Culbertson-Faegre and Jack Hacker and Nick Lombardi
Created with: Godot 3
Game Genre: CCG RTS Roguelite

#### Known bugs:

Pressing a location's menu buttons causes movement.

When moving away from a location, doing it all at once makes the menu disappear, which is expected. What is unexpected, is that moving away from the location in small increments results in the menu staying present, disappearing during subsequent movement, and then reappearing again no matter how far away the player is. The menu keeps showing up until another menu location is displayed, at which point the problem stops.

When the player finds a location with a delivery quest to start and another to complete, and starts the new quest before finishing the old one, the old quest will be able to be completed twice. This bug will not reproduce after the first time it is seen in a given game. Loading a saved game might let it happen again, not sure.

Bishops don't always bounce off edges of Battlefield. It *seems* to depend upon what part of the edge the touch, but it's unclear why that would be.
