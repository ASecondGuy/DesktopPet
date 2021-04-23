extends Sprite


func _process(delta):
	if get_local_mouse_position().length() > 50:
		position+=get_local_mouse_position()/15*delta
	var r := get_rect()
	r.position+=position
	get_parent().update_pet_area(r, scale)
	

