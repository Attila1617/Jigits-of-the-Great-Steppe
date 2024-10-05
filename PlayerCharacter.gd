extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var member

var portraits = {"ASAN":preload("res://Sprites/Concepts/ASAN_IDLE/Asan1.png"),
"ALI":preload("res://Sprites/Concepts/ALI_IDLE/Ali1.png"),
"BERKEATA":preload("res://Sprites/Concepts/BERKEATA_IDLE/BerkeAta1.png"),
"DANA":preload("res://Sprites/Concepts/DANA_IDLE/Dana1.png"),
"ZULAR":preload("res://Sprites/Concepts/ZULAR_IDLE/Zul'Ar1.png")}

var anim_portraits = {"ALI":preload("res://Sprites/ANIMS/ALI.tres"),"ASAN":preload("res://Sprites/ANIMS/ASAN.tres"),
"DANA":preload("res://Sprites/ANIMS/DANA.tres"),"ZULAR":preload("res://Sprites/ANIMS/ZULAR.tres"),
"BERKEATA":preload("res://Sprites/ANIMS/BERKEATA.tres")}

var hover = false

var s = preload("res://Skill.tscn")
var mp 

var multip = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Line2D.set_as_toplevel(true)
	$Line2D.global_position = Vector2(0, 0)
	$Name.text = member["Name"] + " (" + str(member["Chars"]["Level"]) + ")"
	$TextureRect.texture = portraits[member["Name"]]
	$HPBAR.max_value = member["Chars"]["MaxHP"]
	$HPBAR.value = member["Chars"]["HP"]
	mp = member["Chars"]["Spirituality"]
	$MPBAR.max_value = member["Chars"]["Spirituality"]
	$MPBAR.value = mp
	$HP.text = str(member["Chars"]["HP"])
	$MP.text = str(mp)
	$Timer.wait_time = member["Weapon"][2]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	member["Chars"]["HP"] = clamp(member["Chars"]["HP"],-10000,member["Chars"]["MaxHP"])
	mp = clamp(mp, -1, member["Chars"]["Spirituality"])
	$HPBAR.max_value = member["Chars"]["MaxHP"]
	$HPBAR.value = member["Chars"]["HP"]
	$MPBAR.max_value = member["Chars"]["Spirituality"]
	$MPBAR.value = mp
	$HP.text = str(round(member["Chars"]["HP"]))
	$MP.text = str(round(mp))
	if hover and get_parent().get_parent().get_parent().attackingcharacter == null and $Timer.is_stopped() == true:
		self_modulate = Color(0.768627, 0.443137, 0.443137)
	else:
		self_modulate = Color(1, 1, 1)
		if get_parent().get_parent().get_parent().attackingcharacter != null:
			if get_parent().get_parent().get_parent().attackingcharacter != member:
				modulate = Color(0.2, 0.2, 0.2)
			else:
				modulate = Color(1, 1, 1)
		else:
			modulate = Color(1, 1, 1)
	if get_parent().get_parent().get_parent().attackingcharacter != null:
		if get_parent().get_parent().get_parent().attackingcharacter == member:
			$TextureRect.texture = anim_portraits[member["Name"]]
		else:
			$TextureRect.texture = portraits[member["Name"]]
	else:
			$TextureRect.texture = portraits[member["Name"]]
	if member["Chars"]["HP"] <= 0:
		Data.party.erase(member)
		if get_parent().get_parent().get_parent().attackingcharacter == member:
			get_parent().get_parent().get_parent().attackingcharacter = null
		queue_free()
		
		


func _on_PlayerCharacter4_mouse_entered():
	if get_parent().get_parent().get_parent().attackingcharacter == null and $Timer.is_stopped() == true:
		pass
	hover = true
	pass # Replace with function body.


func _on_PlayerCharacter4_mouse_exited():
	hover = false
	pass # Replace with function body.

func _on_PlayerCharacter4_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == 1 and get_parent().get_parent().get_parent().attackingcharacter == null and $Timer.is_stopped() == true:
			get_parent().get_parent().get_parent().attackingcharacter = member
			get_parent().get_parent().get_parent().enemyattack = true
			for x in get_parent().get_parent().get_node("HBoxContainer3").get_children():
				x.queue_free()
			for x in member["Skills"]:
				var ins = s.instance()
				ins.skill = x
				get_parent().get_parent().get_node("HBoxContainer3").add_child(ins)
				
			self_modulate = Color(1, 1, 1)
			
func gonacd(cd):
	$Timer.wait_time = cd
	$TextureProgress.value = 100
	$Tween.interpolate_property($TextureProgress, "value", 100, 0, cd)
	$Tween.start()
	$Timer.start()

func drawline(to):
	$Line2D.clear_points()
	$Line2D.add_point(rect_global_position+Vector2(132,132))
	$Line2D.add_point(to.rect_global_position+Vector2(132,132))
	$Line2D/Tween.interpolate_property($Line2D, "modulate:a",1,0,2)
	$Line2D/Tween.start()


func _on_Timer_timeout():
	multip = 1
	pass # Replace with function body.
