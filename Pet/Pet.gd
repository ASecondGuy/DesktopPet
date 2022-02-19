extends Node2D


var goal_position : Vector2

onready var visual := $Pet

func _ready():
	randomize()
	choose_pos()


func _process(_delta):
	
	if (goal_position-position).length() > 20:
		var dir := ((goal_position-position)/10).clamped(5)
		position += dir
		visual.flip_h = dir.x > 0
		visual.walk()
	else:
		visual.stop_walk()
	update_visible_area()
	


func choose_pos(force=false):
	if $Menus.is_open() and !force: return
	var r = $Menus.get_rect(true)
	goal_position = Vector2(rand_range(0, OS.window_size.x-r.size.x), rand_range(0, OS.window_size.y-r.size.y))


func update_visible_area():
	var r : Rect2= $Menus.get_rect()
	r.position+=position
	get_parent().update_pet_area()
