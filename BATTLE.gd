extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemyattack = false
var ms = preload("res://PlayerCharacter.tscn")
var attackingcharacter
var switch2 = false

var victory = false

var es = preload("res://EnemyPanel.tscn")

var skillscosts = {"BLOCK":5,
"CRUSHINGPUNCH":15,
"RUTHLESSASSAULT":10,
"MIGHTYBLOW":25,
"ACCURATEBLOW":15,
"INSPIRATION":30,
"POISONEDARROW":15,
"SUPPRESSION":25,
"HEALINGFLAMES":15,
"FIRERAIN":40}

var curskill

var poison = preload("res://Poison.tscn")

func _ready():
	for x in Data.party:
		var mi = ms.instance()
		mi.member = x
		$CanvasLayer/HBoxContainer.add_child(mi)
		pass
	for x in Data.enemy_layouts[Data.layout]:
		var ei = es.instance()
		for y in x.keys():
			ei.set(y,x[y])
		$CanvasLayer/HBoxContainer2.add_child(ei)
	Data.layout = null
	
	
	
	
	pass # Replace with function body.
	
func get_member_panel(member):
	for x in get_tree().get_nodes_in_group("PlayerPanel"):
		if x.member == member:
			return x
			
func skill(sk):
	var p = get_member_panel(attackingcharacter)
	if p.mp >= skillscosts[sk]:
		p.mp -= skillscosts[sk]
	else:
		return
	match sk:
		"HEALINGFLAMES":
			for x in Data.party:
				x["Chars"]["HP"] += 10
			get_member_panel(attackingcharacter).gonacd(7)
			attackingcharacter = null
		"FIRERAIN":
			for x in $CanvasLayer/HBoxContainer2.get_children():
				x.recieve_damage()
			attackingcharacter = null
		"SUPPRESSION":
			for x in $CanvasLayer/HBoxContainer2.get_children():
				x.gonacd(6)
			get_member_panel(attackingcharacter).gonacd(15)
			attackingcharacter = null
		"POISONEDARROW":
			curskill = "POISONEDARROW"
		"BLOCK":
			get_member_panel(attackingcharacter).multip = 0.3
			get_member_panel(attackingcharacter).gonacd(20)
			attackingcharacter = null
		"CRUSHINGPUNCH":
			curskill = "CRUSHINGPUNCH"
		"RUTHLESSASSAULT":
			attackingcharacter["Chars"]["HP"] += 30
			for x in $CanvasLayer/HBoxContainer2.get_children():
				x.recieve_damage()
			get_member_panel(attackingcharacter).gonacd(13)
			attackingcharacter = null
		"MIGHTYBLOW":
			curskill = "MIGHTYBLOW"
		"INSPIRATION":
			for x in Data.party:
				get_member_panel(x).mp += 30
			get_member_panel(attackingcharacter).gonacd(25)
			attackingcharacter = null
		"ACCURATEBLOW":
			curskill = "ACCURATEBLOW"
			
			pass
	pass
	
func dskill(target):
	match curskill:
		null:
			pass
		"POISONEDARROW":
			target.add_child(poison.instance())
		"CRUSHINGPUNCH":
			target.gonacd(8)
		"MIGHTYBLOW":
			target.hp -= 35
		"ACCURATEBLOW":
			target.hp -= 15
			target.gonacd(4)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attackingcharacter == null:
		curskill = null
		for x in $CanvasLayer/HBoxContainer3.get_children():
			x.queue_free()
	if Input.is_action_just_pressed("ui_cancel"):
		attackingcharacter = null
	var switch = false

	for x in Data.party:
		if x["Name"] == "ASAN":
			switch = true
	if switch == false and switch2 == false:
		$CanvasLayer/Outro.play()
		switch2 = true
	if $CanvasLayer/HBoxContainer2.get_children().size() == 0 and switch2 == false:
		$CanvasLayer/Outro.play()
		victory = true
		switch2 = true
	if curskill != null:
		for x in $CanvasLayer/HBoxContainer3.get_children():
			if x.skill != curskill:
				x.visible = false
		pass
