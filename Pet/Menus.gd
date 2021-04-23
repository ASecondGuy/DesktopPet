extends Container

onready var limits := $Limits


func _on_Menus_sort_children():
	var obtn = $OpenBtn
	obtn.rect_size = Vector2()
	obtn.rect_position = rect_size/2-obtn.rect_size/Vector2(2, -2.5)
	
	var awaybtn = $goAway
	awaybtn.rect_size = Vector2()
	awaybtn.rect_position = rect_size/2-awaybtn.rect_size/Vector2(2, 1.5)
	

func is_open()->bool:
	return limits.visible


func get_rect(force=false)->Rect2:
	if is_open() or force:
		return .get_rect().merge($Limits.get_rect())
	return .get_rect()



func _on_OpenBtn_pressed():
	limits.visible = !limits.visible
	get_parent().update_visible_area()
