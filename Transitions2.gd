extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var faded = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if Data.events.has("TRANS"):
		queue_free()
	pass # Replace with function body.

func fade():
	add_to_group("BLOCKER")
	$Tween.interpolate_property(self, "modulate:a", 0, 1, 2)
	$Tween.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_completed(object, key):
	yield(get_tree().create_timer(1),"timeout")
	if faded == false:
		for x in get_tree().get_nodes_in_group("NPC"):
			x.queue_free()
		
		get_tree().get_nodes_in_group("ASAN")[0].global_position = get_parent().get_parent().get_node("4").global_position
		get_parent().get_parent().get_node("TileMap").modulate = Color(0.768627, 0.462745, 0.031373)
		$Tween.interpolate_property(self, "modulate:a", 1, 0, 2)
		$Tween.start()
		faded = true
		Data.events.append("TRANS")
		get_parent().get_parent().get_node("GUI/CUTSCENE").play()
	else:
		queue_free()
	Save.savegame()
	pass # Replace with function body.

