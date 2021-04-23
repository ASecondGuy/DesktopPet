extends Sprite

var mov := Vector2(-1, 1)
var window_rect := Rect2() 



func _ready():
	OS.window_position = Vector2()
	OS.window_size = OS.get_screen_size()-Vector2(0, 1)
	window_rect = Rect2(OS.window_position, OS.window_size)
	get_viewport().transparent_bg = true
	update_mouse_blocker()

func update_mouse_blocker():
	var points := []
	var r := get_rect()
	r.position+=position
	var grow_val : Vector2 = r.size*(scale-Vector2(1, 1))/2
	r = r.grow_individual(grow_val.x, grow_val.y, grow_val.x, grow_val.y)
	
	points.push_back(r.position)
	points.push_back(Vector2(r.position.x+r.size.x, r.position.y))
	points.push_back(r.position+r.size)
	points.push_back(Vector2(r.position.x, r.position.y+r.size.y))
	
	
	OS.set_window_mouse_passthrough(PoolVector2Array(points))
	

func _process(delta):
	position+=mov*200*delta
	update_mouse_blocker()
	var r = window_rect
	if position.x < r.position.x:
		mov.x=1
	elif position.x > r.size.x:
		mov.x=-1
	if position.y < r.position.y:
		mov.y=1
	elif position.y > r.size.y:
		mov.y=-1


