extends TextEdit

onready var save_timer = $saveTimer

const NOTES_PATH := "user://notes.txt"


func _ready():
	#load
	var f = File.new()
	if f.open(NOTES_PATH, File.READ) != OK: return
	
	text = f.get_as_text()
	
	f.close()



func _on_Notes_text_changed():
	save_timer.start()


func _on_saveTimer_timeout():
	var f = File.new()
	if f.open(NOTES_PATH, File.WRITE) != OK: return
	
	f.store_string(text)
	print("Notes saved")
	f.close()
