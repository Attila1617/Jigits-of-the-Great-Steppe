extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var skill 

# Called when the node enters the scene tree for the first time.
func _ready():
	text = tr("TR"+skill) + " (" + str(get_parent().get_parent().get_parent().skillscosts[skill])+")"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Skill_pressed():
	get_parent().get_parent().get_parent().skill(skill)
	pass # Replace with function body.
