extends Node


var window_rect := Rect2() 
var check_mous_outside := false

onready var line := $"debugdraw/Line2D"


func _ready():
	Engine.target_fps = 30
	OS.window_position = Vector2()
	OS.current_screen = 1
	OS.window_size = OS.get_screen_size()-Vector2(0, 1)
	window_rect = Rect2(OS.window_position, OS.window_size)
	get_viewport().transparent_bg = true
	update_pet_area()



func update_pet_area(r:=window_rect, scale:=Vector2.ONE):
#	if Engine.get_frames_drawn()%20<1 and check_mous_outside:
#	OS.set_window_mouse_passthrough([])
		
#		return
	

	var points := []
	var grow_val : Vector2 = r.size*(scale-Vector2(1, 1))/2
	r = r.grow_individual(grow_val.x, grow_val.y, grow_val.x, grow_val.y)
	
	points.push_back(r.position)
	points.push_back(Vector2(r.position.x+r.size.x, r.position.y))
	points.push_back(r.position+r.size)
	points.push_back(Vector2(r.position.x, r.position.y+r.size.y))
	
	var polygons = [points.duplicate()]
	for c in $paths.get_children():
		polygons.push_back(c.curve.get_baked_points())
	
	points.clear()
	print("")
	while true:
		for i in range(polygons.size()):
			var p1 = polygons[i]
			if p1 == null: continue
			for i2 in range(i, polygons.size()):
				print(i, i2)
				var p2 = polygons[i2]
				if p2 == null: continue
				
				if _polygons_intesect(p1, p2):
					var result = Geometry.merge_polygons_2d(p1, p2)
					polygons[i] = result[0]
					p2 = null
		
		while polygons.has(null):
			polygons.remove(polygons.find_last(null))
		
		var loop_finished := true
		for i in range(polygons.size()):
			for i2 in range(i, polygons.size()):
				if i == i2: continue
				if !_polygons_intesect(polygons[i], polygons[i2]):
					loop_finished = false
		
		if loop_finished: break
		break
	
	for poly in polygons:
		for p in poly:
			points.push_back(p)
		points.push_back(poly[0])
	
	line.clear_points()
	for p in points:
		line.add_point(p)
	
#	OS.call_deferred("set_window_mouse_passthrough", PoolVector2Array(points))
	

func _polygons_intesect(p1, p2)->bool:
#	prints("Inter:", Geometry.intersect_polygons_2d(p1, p2).size())
	return Geometry.intersect_polygons_2d(p1, p2).size() > 0

