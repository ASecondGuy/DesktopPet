extends Node


var window_rect := Rect2() 
var check_mous_outside := false



func _ready():
	Engine.target_fps = 30
	OS.window_position = Vector2()
	OS.window_size = OS.get_screen_size()-Vector2(0, 1)
	window_rect = Rect2(OS.window_position, OS.window_size)
	get_viewport().transparent_bg = true
	update_pet_area()



func update_pet_area(r:=window_rect, scale:=Vector2.ONE):
	if Engine.get_frames_drawn()%20<1 and check_mous_outside:
		OS.set_window_mouse_passthrough([])
		return
	
	
	var points := []
	var grow_val : Vector2 = r.size*(scale-Vector2(1, 1))/2
	r = r.grow_individual(grow_val.x, grow_val.y, grow_val.x, grow_val.y)
	
	points.push_back(r.position)
	points.push_back(Vector2(r.position.x+r.size.x, r.position.y))
	points.push_back(r.position+r.size)
	points.push_back(Vector2(r.position.x, r.position.y+r.size.y))
	
	
	OS.set_window_mouse_passthrough(PoolVector2Array(points))
	



