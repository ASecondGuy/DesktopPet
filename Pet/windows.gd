extends Control


func _ready():
	
	for popup in get_children():
		# Don't do this if it is not a popup
		if !popup is WindowDialog: continue
		
		popup.connect("gui_input", self, "_on_input", [popup])


func _on_input(event:InputEvent, window:WindowDialog):
	if event is InputEventMouseButton:
		move_child(window, get_child_count()-1)

