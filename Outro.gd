extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


func play():
	visible = true
	$AnimationPlayer.play("1")


func _on_AnimationPlayer_animation_finished(anim_name):
	yield(get_tree().create_timer(1),"timeout")
	if get_parent().get_parent().victory == false:
		Save.loadgame()
		Data.enemy_id = false
		get_tree().change_scene("res://Main Menu.tscn")
	else:
		Save.savepartygame()
		Save.loadgame()
		get_tree().change_scene("res://World.tscn")
	pass # Replace with function body.

