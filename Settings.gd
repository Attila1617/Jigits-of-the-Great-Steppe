extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$OptionButton.add_item("ENG")
	$OptionButton.add_item("RUS")
	if "ru" in TranslationServer.get_locale():
		$OptionButton.selected = 1
	else:
		$OptionButton.selected = 0
	$CheckBox.pressed = Data.settings["fullscreen"]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CheckBox_pressed():
	OS.window_fullscreen = $CheckBox.pressed
	Data.settings["fullscreen"] = $CheckBox.pressed
	pass # Replace with function body.


func _on_OptionButton_item_selected(index):
	if index == 0:
		TranslationServer.set_locale("en")
		Data.settings["locale"] = "en"
	if index == 1:
		TranslationServer.set_locale("ru")
		Data.settings["locale"] = "ru"
	pass # Replace with function body.


func _on_Button_pressed():
	Save.savegame()
	get_tree().change_scene("res://Main Menu.tscn")
	pass # Replace with function body.
