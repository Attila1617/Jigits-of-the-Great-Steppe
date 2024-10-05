extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movespeed = 300
var accspeed = 500

var back = false
# Called when the node enters the scene tree for the first time.
func _process(delta):
	var s = false
	for x in $Interaction.get_overlapping_areas():
		s = true
		if x.get_parent().get("need_dialogue") != null:
			if x.get_parent().need_dialogue and x.get_parent().cantdial == false:
				$Sprite.visible = true
			else:
				$Sprite.visible = false
		else:
			$Sprite.visible = false
	if s == false:
		$Sprite.visible = false
	var movvector = Vector2(0,0)
	if get_tree().get_nodes_in_group("BLOCKER").size() == 0:
		if Input.is_action_pressed("ui_down"):
			movvector.y = 1
			back = false
		elif Input.is_action_pressed("ui_up"):
			movvector.y = -1
			back = true
		if Input.is_action_pressed("ui_left"):
			movvector.x= -1
		elif Input.is_action_pressed("ui_right"):
			movvector.x = 1
	move_and_slide(movvector.normalized()*movespeed)
	var b 
	match back:
		true:
			b = "BACK_"
		false:
			b = ""
	if movvector.length_squared() == 0:
		$AnimatedSprite.play(b+"IDLE")
		$Particles2D.emitting = false
	else:
		$AnimatedSprite.play(b+"MOVE")
		$Particles2D.emitting = true
	
func give_data():
	return {"filename":filename,
	"position.x":position.x,
	"position.y":position.y
	}
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
