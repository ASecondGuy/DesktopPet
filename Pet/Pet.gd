extends Node2D
# This is the pet itself
# You can make as many as you'd like in theory and this can be anything you like.
# As long as everything you want on screen is in the Cutout group and overwrites
# get_cutout_polygon() or is a Control, Path2D or Sprite. Those 3 have automatic
# polygons assinged if they don't overwrite get_cutout_polygon()

var goal_position : Vector2

onready var visual := $PetVisuals
onready var buttons := $Buttons


func _ready():
	randomize()
	choose_pos()


func _process(_delta):
	
	if (goal_position-position).length() > 20:
		var dir := ((goal_position-position)/10).clamped(5)
		position += dir
		visual.flip_h = dir.x > 0
		visual.walk()
#		get_node("/root/Root").update_pet_area()
	else:
		visual.stop_walk()
	


func choose_pos():
	var r = buttons.get_rect()
	goal_position = Vector2(rand_range(0, OS.window_size.x-r.size.x), rand_range(0, OS.window_size.y-r.size.y))

