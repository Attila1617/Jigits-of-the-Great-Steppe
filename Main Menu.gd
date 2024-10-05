extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var goto = "Settings"

# Called when the node enters the scene tree for the first time.
func _ready():
	Data.enemy_id = null
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button3_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Button2_pressed():
	goto = "Settings"
	$Transition/AnimationPlayer.play("2")
	$Transition.mouse_filter=Control.MOUSE_FILTER_STOP
	pass # Replace with function body.


func _on_Button_pressed():
	$Transition.modulate = Color(0, 0, 0)
	goto = "World"
	Save.loadgame()
	$Transition/AnimationPlayer.play("2")
	$Transition.mouse_filter=Control.MOUSE_FILTER_STOP
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "2":
		match goto:
			"Settings":
				yield(get_tree().create_timer(0.5),"timeout")
				get_tree().change_scene("res://Settings.tscn")
			"World":
				yield(get_tree().create_timer(0.5),"timeout")
				get_tree().change_scene("res://World.tscn")
	pass # Replace with function body.
