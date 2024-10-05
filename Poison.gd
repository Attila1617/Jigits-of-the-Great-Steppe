extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Poison_timeout():
	get_parent().hp -= 1
	counter += 1
	if counter == 20:
		queue_free()
	pass # Replace with function body.
