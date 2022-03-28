# DesktopPet

You want a pet on your desktop? This might someday be what you are looking for.
For now it is just a proof of concept that it can be done.

Feel free to insert your own Pet and add or remove features all you want

## Features:
- Notes Panel
- configurable shortcuts
- a calculator
- a balloon minigame
- A Rectangle friend who likes to pick some boogers out his nose

## Making a pet from scratch
To not block clicks everywhere you need one passthrou polygon.<br />
Combinding polygons is already managed for you by the root node.<br />
You only need to put all your nodes you want to be seen into the Cutout group.<br />
Control, Path2D and Sprite Nodes will work automatically.<br />
To customize theyr behaviour or use other nodes you have to overwrite get_cutout_polygon().<br />
That should return a array of points for the polygon. <br />
(All nodes inheriting from Control will also work, Path2D will result in a polygon not a path)





If you like this and want to see development continue consider to

<a href="https://www.buymeacoffee.com/ASecondGuy" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
