extends VBoxContainer
# Mouse position is being weird with passthrough.
# I'm not sure what would be the best way to solve it.


onready var ignore_mouse := $ignore_mouse_timer
var mouse_inside := false

var following := false


func _process(delta):
	_test_mouse_pos()
	var change : float = [-delta, delta][int(mouse_inside)]*5
	
	if mouse_inside and !ignore_mouse.time_left > 0:
		get_parent().goal_position = get_parent().global_position
	modulate.a = clamp(modulate.a+change, 0, 1)
	
	for b in get_children():
		if b is BaseButton:
			b.disabled = !_can_use_btns()

func _ready():
	for b in get_children():
		if b is Control:
			b.connect("mouse_entered", self, "set", ["mouse_inside", true])
#			b.connect("mouse_exited", self, "set", ["mouse_inside", false])





func _on_follow_toggled(button_pressed):
	following = button_pressed

func _can_use_btns()->bool:
	if ignore_mouse.time_left > 0: return false
	if modulate.a < .8: return false
	return true

func _test_mouse_pos():
	mouse_inside = get_global_rect().grow(-10).has_point(get_global_mouse_position())

func _on_Buttons_mouse_exited():
	mouse_inside = false


func _on_goAway_pressed():
	ignore_mouse.start()
	mouse_inside = false
	get_parent().choose_pos()
