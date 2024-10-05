extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var hp = 100
export var maxhp = 100
export var attackpower = 10
export var cd = 7
export var counterpercent = 0.1
export var type = 'dzungar1'
export var atype = "MELEE"
var dzungaranimation = {'dzungar1': preload('res://Sprites/ANIMS/Dzungar1.tres'), 'dzungar2': preload('res://Sprites/ANIMS/Dzungar2.tres'), 'dzungar3': preload('res://Sprites/ANIMS/Dzungar3.tres'), 'dzungar4': preload('res://Sprites/ANIMS/Dzungar4.tres')}
var burst = preload("res://Attacks/Fireburst.tscn")

export var xpvalue = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	$HP2.text = str(hp)
	$HP.max_value = maxhp
	$HP.value = hp
	$TextureRect.texture = dzungaranimation[type]
	$Line2D.global_position = Vector2(0,0)
	$Line2D.set_as_toplevel(true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HP2.text = str(round(hp))
	$HP.max_value = maxhp
	$HP.value = hp
	if hp <= 0:
		var xp = float(xpvalue)/Data.party.size()
		for x in Data.party:
			x["Chars"]["EXP"] += xp
		queue_free()
	
	if get_parent().get_parent().get_parent().enemyattack == true:
		if $cooldown.is_stopped() and $topas.is_stopped():
			$topas.wait_time = rand_range(0.5, 3.0)
			$topas.start()

func gonacd(cd):
	$topas.stop()
	$TextureProgress.value = 100
	$Tween.interpolate_property($TextureProgress, "value",100, 0, cd)
	$cooldown.wait_time = cd
	$cooldown.start()

func _on_EnemyPanel_mouse_entered():
	if get_parent().get_parent().get_parent().attackingcharacter != null:
		modulate = Color(0.768627, 0.443137, 0.443137)
	pass # Replace with function body.


func _on_EnemyPanel_mouse_exited():
	modulate = Color(1, 1, 1)
	pass # Replace with function body.

func get_member_panel(member):
	for x in get_tree().get_nodes_in_group("PlayerPanel"):
		if x.member == member:
			return x
func _on_EnemyPanel_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == 1 and get_parent().get_parent().get_parent().attackingcharacter != null:
			var attacker = get_member_panel(get_parent().get_parent().get_parent().attackingcharacter)
			if is_instance_valid(attacker):
				hp -= (get_parent().get_parent().get_parent().attackingcharacter["Weapon"][3])+(get_parent().get_parent().get_parent().attackingcharacter["Weapon"][4]*get_parent().get_parent().get_parent().attackingcharacter["Chars"]["Level"])
				get_parent().get_parent().get_parent().dskill(self)
				if attacker.member["Weapon"][1] == "MELEE":
					attacker.member["Chars"]["HP"] -= attackpower*counterpercent
				if attacker.member["Weapon"][0] == "FIREBURST":
					var i = burst.instance()
					i.global_position = rect_global_position+Vector2(132,132)
					get_parent().get_parent().get_parent().get_node("CanvasLayer2").add_child(i)
				attacker.gonacd(get_parent().get_parent().get_parent().attackingcharacter["Weapon"][2])
				attacker.drawline(self)
				get_parent().get_parent().get_parent().attackingcharacter = null

	pass # Replace with function body.
func recieve_damage():
	var attacker = get_member_panel(get_parent().get_parent().get_parent().attackingcharacter)
	if is_instance_valid(attacker):
		hp -= (get_parent().get_parent().get_parent().attackingcharacter["Weapon"][3])+(get_parent().get_parent().get_parent().attackingcharacter["Weapon"][4]*get_parent().get_parent().get_parent().attackingcharacter["Chars"]["Level"])
		if attacker.member["Weapon"][1] == "MELEE":
			attacker.member["Chars"]["HP"] -= attackpower*counterpercent
		if attacker.member["Weapon"][0] == "FIREBURST":
			var i = burst.instance()
			i.global_position = rect_global_position+Vector2(132,132)
			get_parent().get_parent().get_parent().get_node("CanvasLayer2").add_child(i)
		attacker.gonacd(get_parent().get_parent().get_parent().attackingcharacter["Weapon"][2])

func _on_topas_timeout():
	var battle = get_parent().get_parent().get_parent()
	var players = []
	for x in battle.get_node('CanvasLayer/HBoxContainer').get_children():
		players.append(x)
	if players.size() == 0:
		return
	players.shuffle()
	var target = players[0] 
	target.member['Chars']['HP'] -= attackpower*target.multip
	if atype == "MELEE":
		hp -= ((target.member['Weapon'][3])+(target.member['Weapon'][4]*target.member['Chars']["Level"]))*target.member['Weapon'][5]
	$Line2D.clear_points()
	$Line2D.global_position = Vector2(0,0)
	$Line2D.add_point(rect_global_position+Vector2(132,132))
	$Line2D.add_point(target.rect_global_position+Vector2(132,132))
	$Line2D/Tween.interpolate_property($Line2D, "modulate:a",1,0,2)
	$Line2D/Tween.start()
	$TextureProgress.value = 100
	$Tween.interpolate_property($TextureProgress, "value",100, 0, cd)
	$cooldown.wait_time = cd
	$cooldown.start()
	$Tween.start()
