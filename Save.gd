extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var data 

var d

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

func savegame():
	var f = File.new()
	f.open("user://save.jots",File.WRITE)
	f.store_line(to_json(Data.settings))
	f.store_line(to_json(Data.party))
	f.store_line(to_json(Data.events))
	if get_tree().get_nodes_in_group("WORLD").size() > 0:
		f.open("user://wsave.jots",File.WRITE)
		f.store_line(to_json(get_tree().get_nodes_in_group("WORLD")[0].saving()))
	f.close()

	pass
	
func savepartygame():
	var f = File.new()
	f.open("user://save.jots",File.WRITE)
	f.store_line(to_json(Data.settings))
	f.store_line(to_json(Data.party))
	f.store_line(to_json(Data.events))
	f.close()

	pass

func loadgame():
	var f = File.new()
	var f2 = File.new()
	if f.open("user://save.jots",File.READ) != OK:
		return
	Data.settings = parse_json(f.get_line())
	Data.party = parse_json(f.get_line())
	Data.events = parse_json(f.get_line())
	if f2.open("user://wsave.jots",File.READ) != OK:
		return
	data = parse_json(f2.get_line())
	d = data
	f.close()
	f2.close()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
