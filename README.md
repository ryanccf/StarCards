Star Cards Project Outline
Designer/Developers: Ryan Culbertson-Faegre and Jack Hacker and Nick Lombardi
Created with: Godot 3
Game Genre: CCG RTS Roguelite

#### Known bugs:

Pressing a location's menu buttons causes movement.

When moving away from a location, doing it all at once makes the menu disappear, which is expected. What is unexpected, is that moving away from the location in small increments results in the menu staying present, disappearing during subsequent movement, and then reappearing again no matter how far away the player is. The menu keeps showing up until another menu location is displayed, at which point the problem stops.

Sometimes, under unknown conditions, a location will continue allowing you to start a delivery mission. If you start this delivery mission four times (for example), there will be four deliveries to complete at the destination location. For some reason, accepting one of these seems to remove two of them. Not sure exactly how this scales with number, have had trouble reproducing this bug.

Sometimes, under unknown conditions (only cited once while a new delivery quest was available at the location in question), a location with a delivery to complete will create two copies of the delivery instead of removing it. WHen one of these was selected, the other one also disappeared.

Bishops don't always bounce off edges of Battlefield. It *seems* to depend upon what part of the edge the touch, but it's unclear why that would be.