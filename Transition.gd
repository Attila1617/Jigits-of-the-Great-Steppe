extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("New Anim")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if get_parent().has_method("_on_AnimationPlayer_animation_finished"):
		get_parent()._on_AnimationPlayer_animation_finished(anim_name)
	pass # Replace with function body.
