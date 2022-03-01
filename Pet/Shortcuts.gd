extends VBoxContainer

onready var conf_btn := $Configs
onready var add_btn := $Configs/add
onready var rem_btn := $Configs/remove
onready var _list := $Scroll/list


const SHORTCUT_SAVE_PATH := "user://shortcuts.json"

var shortcut_paths := []


func _ready():
	#load
	var f = File.new()
	if f.open(SHORTCUT_SAVE_PATH, File.READ) != OK: return
	
	shortcut_paths = parse_json(f.get_as_text())
	refresh_list()
	f.close()
	

func refresh_list():
	for c in _list.get_children():
		c.queue_free()
	
	for path in shortcut_paths:
		var btn := Button.new()
		btn.clip_text = true
		btn.text = path.get_file()
		_list.add_child(btn)
# warning-ignore:return_value_discarded
		btn.connect("pressed", self, "pressed", [path])
	
	


func save(data=shortcut_paths):
	var f = File.new()
	if f.open(SHORTCUT_SAVE_PATH, File.WRITE) != OK: return
	
	f.store_string(to_json(data))
	print("Shortcuts saved")
	f.close()


func pressed(path:String):
	
	if rem_btn.pressed:
		shortcut_paths.erase(path)
		save()
		refresh_list()
		return
	
	
	match (path.get_extension()):
		"exe":
			var drive = path.split("/")[0]
			var command = str(drive, " && cd ", path.get_base_dir().trim_prefix(drive))
			command+=" && start "+ path.get_file()+" & exit"
			
			prints("Started:", OS.execute("cmd.exe", ["/C", command], false))
		_:
			# warning-ignore:return_value_discarded
			OS.shell_open(path)








func _on_FileDialog_file_selected(path):
	shortcut_paths.push_back(path)
	save()
	refresh_list()




#config btns
func _on_Configure_pressed():
	add_btn.visible = !add_btn.visible
	rem_btn.visible = !rem_btn.visible
	rem_btn.pressed = false

func _on_add_pressed():
	$"../../FileDialog".popup(get_global_rect())


