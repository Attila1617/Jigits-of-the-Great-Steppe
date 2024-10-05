extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var TAB = "Squad"
var religs = {"TENGRI":preload("res://Sprites/Religions/Tengrianism.png"), "ZOROASTRI":preload("res://Sprites/Religions/Zoroastrianism.png")}
var ms = preload("res://Member.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func descmember(mname):
	for x in Data.party:
		if x["Name"] == mname:
			var member = x
			$Desc/TextureRect.texture = load("res://Sprites/ANIMS/"+mname+".tres")
			$Desc/Label2.text = tr("TR"+mname)
			$Desc/Label.text = tr("TR"+mname+"D")
			$Desc/Label3.text = tr("TR"+x["Class"])
			$Desc/TextureRect2.texture = religs[x["Faith"]]
			$Desc/Label4.text = tr("TR"+x["Faith"])
			$Desc/Label5.text = tr("TRLEVEL") + " - "+str(x["Chars"]["Level"]) + " \n" + tr("TREXP") + " - "+str(round(x["Chars"]["EXP"]))  + " \n" + tr("TRNEXTEXP") + " - "+str(round(x["Chars"]["EXPtoLevel"]))
			$Desc/Label6.text = tr("TRHP") + " - "+str(round(x["Chars"]["HP"])) + " \n" + tr("TRSPIRITUALITY") + " - "+str(round(x["Chars"]["Spirituality"]))
			$Desc/TextureRect2.hint_tooltip = tr("TR"+x["Faith"]+"D")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if visible:
			visible = false
			remove_from_group("BLOCKER")
		else:
			if get_tree().get_nodes_in_group("BLOCKER").size() != 0:
				return
			for x in $Squad.get_children():
				x.queue_free()
			for x in Data.party:
				var mi = ms.instance()
				mi.mname = x["Name"]
				mi.level = x["Chars"]["Level"]
				mi.mclass = x["Class"]
				$Squad.add_child(mi)
			visible = true
			add_to_group("BLOCKER")


func _on_Button2_pressed():
	Save.savegame()
	get_tree().change_scene("res://Main Menu.tscn")
	pass # Replace with function body.


func _on_Button3_pressed():
	if visible:
		visible = false
		remove_from_group("BLOCKER")

	pass # Replace with function body.
