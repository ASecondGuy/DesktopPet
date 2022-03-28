extends Sprite
# This is a way to do it.
# Continue or don't. I don't care.


onready var anim : AnimationPlayer = $AnimationPlayer
var idle_variations := 1


func _ready():
	randomize()


func get_animation_player()->AnimationPlayer:
	return anim

func walk():
	anim.play("walk")

func stop_walk():
	if anim.current_animation == "walk":
		anim.play("idle")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "walk": return
	
	if randi() % 10 == 0:
		if idle_variations == 1:
			anim.play("idle_1")
		elif idle_variations > 1:
			anim.play("idle_"+str((randi() % idle_variations)+1))
		else:
			anim.play("idle")
	else:
		anim.play("idle")
