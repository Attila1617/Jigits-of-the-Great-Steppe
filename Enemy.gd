extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var id = 1
export var layout = '1'

export var type = "dzungar1"
var dzungaranimation = {'dzungar1': preload('res://Sprites/ANIMS/Dzungar1.tres'), 'dzungar2': preload('res://Sprites/ANIMS/Dzungar2.tres'), 'dzungar3': preload('res://Sprites/ANIMS/Dzungar3.tres'), 'dzungar4': preload('res://Sprites/ANIMS/Dzungar4.tres')}


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree(),"idle_frame")
	$AnimatedSprite.texture = dzungaranimation[type]
	if Data.enemy_id != null:
		if Data.enemy_id == id:
			queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Interaction_area_entered(area):
	if $Timer.is_stopped() == false:
		return
	Save.savegame()
	Data.enemy_id = id
	Data.layout = layout
	get_tree().get_nodes_in_group("BATTLEANIM")[0].playanim()
	pass # Replace with function body.
	
func give_data():
	return {"filename":filename,
	"position.x":position.x,
	"position.y":position.y,
	"type":type,
	"id":id,
	"layout":"1",
}
