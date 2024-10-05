extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var effects = []

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	$Tween.interpolate_property(self,"modulate:a",0,1,0.7)
	$Tween.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	for x in effects:
		get_parent().get_parent().effect(x)
	pass # Replace with function body.
