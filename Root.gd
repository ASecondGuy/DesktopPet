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



func update_pet_area():
	
	var polygons = []
	for node in get_tree().get_nodes_in_group("Cutout"):
		if node.has_method("get_cutout_polygon"):
			polygons.push_back(node.get_cutout_polygon())
		
		if Array(ClassDB.get_inheriters_from_class("Control")).has(node.get_class()):
			if !node.is_visible_in_tree(): continue
			var pol := []
			var r : Rect2 = node.get_global_rect()
			r = r.grow(5)
			pol.push_back(r.position)
			pol.push_back(Vector2(r.position.x+r.size.x, r.position.y))
			pol.push_back(r.position+r.size)
			pol.push_back(Vector2(r.position.x, r.position.y+r.size.y))
			polygons.push_back(pol)
		if node.get_class() == "Path2D":
			polygons.push_back(node.curve.get_baked_points())
	
	var points := []
	
	
	
	points.clear()
	while _polygons_overlap(polygons):
		for i in range(polygons.size()):
			for i2 in range(polygons.size()):
				var pol = polygons[i]
				var pol2 = polygons[i2]
				if i == i2: continue
				if pol == null or pol2 == null: continue
				if _polygons_intesect(pol, pol2):
					polygons[i] = Geometry.merge_polygons_2d(pol, pol2)[0]
					polygons[i2] = null
		
		while polygons.has(null):
			polygons.remove(polygons.find_last(null))
	
	for poly in polygons:
		for p in poly:
			points.push_back(p)
		points.push_back(poly[0])
	
	########
	line.clear_points()
	for p in points:
		line.add_point(p)
	OS.call_deferred("set_window_mouse_passthrough", PoolVector2Array(points))
	

func _polygons_intesect(p1, p2)->bool:
#	prints("Inter:", Geometry.intersect_polygons_2d(p1, p2).size())
	return Geometry.intersect_polygons_2d(p1, p2).size() > 0

func _polygons_overlap(polygons:Array)->bool:
	for i in range(polygons.size()):
		for i2 in range(polygons.size()):
			if i <= i2: continue
			if _polygons_intesect(polygons[i], polygons[i2]):
				return true
	return false
