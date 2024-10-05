extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var character = "BERKEATA"
export var dialogue = "ALI1"
export var need_dialogue = false
var cantdial = false
var joiningdials = ["ALI1", "BERKEATA1", "DANA1","ZULAR1"]

var p = false
var ds = preload("res://Dialogue_Screen.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if joiningdials.has(dialogue) and Data.party.size() >= 4:
		cantdial = true
	else:
		cantdial = false
	$AnimatedSprite.play(character+"_IDLE")
	if need_dialogue and cantdial == false:
		$AnimatedSprite2.visible = true
	else:
		$AnimatedSprite2.visible = false
	if Input.is_action_just_pressed("ui_accept") and get_tree().get_nodes_in_group("BLOCKER").size() == 0:
		if need_dialogue and p and cantdial == false:
			var d = ds.instance()
			d.speaker1 = "ASAN"
			d.speaker2 = character
			d.dialogue = dialogue
			get_parent().get_parent().get_node("GUI").add_child(d)
		pass
	pass


func _on_Interaction_area_entered(area):
	if area.type == "PLAYER":
		p = true
	pass # Replace with function body.


func _on_Interaction_area_exited(area):
	if area.type == "PLAYER":
		p = false
	pass # Replace with function body.

func give_data():
	return {"filename":filename,
	"position.x":position.x,
	"position.y":position.y,
	"character":character,
	"need_dialogue":need_dialogue,
	"dialogue":dialogue
	}
