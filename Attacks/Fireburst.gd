extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var em1 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	emitting = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if emitting == false and em1 == false:
		$Particles2D.emitting = true
		em1 = true
	
	pass


func _on_Timer_timeout():
	queue_free()
	pass # Replace with function body.
