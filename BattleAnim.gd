extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	mouse_filter=Control.MOUSE_FILTER_IGNORE
	pass # Replace with function body.

func playanim():
	visible = true
	add_to_group("BLOCKER")
	mouse_filter=Control.MOUSE_FILTER_STOP
	$AnimationPlayer.play("1")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
