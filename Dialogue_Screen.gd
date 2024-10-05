extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speaker1 = "ASAN"
var speaker2 = "ALI"


onready var dialogues = {"ALI1":
	{"1":
		{"Text":tr("TRALID1_1"), 
		"Answers":[
			[tr("TRALID1_1A1"),["GOTO_2"]],
			[tr("TRALID1_1A2"),["END"]]
			]
		},
	"2":
		{"Text":tr("TRALID1_2"), 
		"Answers":[
			[tr("TRENDCONVERSATION"),["ADDTOPARTY_ALI","NEGLECT_ALI","KILLNPC_ALI","END"]]
			]
		}

		},
"BERKEATA1":
	{"1":
		{"Text":tr("TRBERKEATAD1_1"), 
		"Answers":[
			[tr("TRBERKEATAD1_1A1"),["GOTO_2"]],
			[tr("TRBERKEATAD1_1A2"),["END"]]
			]
		},
	"2":
		{"Text":tr("TRBERKEATAD1_2"), 
		"Answers":[
			[tr("TRENDCONVERSATION"),["ADDTOPARTY_BERKEATA","NEGLECT_BERKEATA","KILLNPC_BERKEATA","END"]]
			]
		}

		},
		
"DANA1":
	{"1":
		{"Text":tr("TRDANAD1_1"), 
		"Answers":[
			[tr("TRDANAD1_1A1"),["GOTO_2"]],
			[tr("TRDANAD1_1A2"),["END"]]
			]
		},
	"2":
		{"Text":tr("TRDANAD1_2"), 
		"Answers":[
			[tr("TRENDCONVERSATION"),["ADDTOPARTY_DANA","NEGLECT_DANA","KILLNPC_DANA", "END"]]
			]
		}

		},
"ZULAR1":
	{"1":
		{"Text":tr("TRZULARD1_1"), 
		"Answers":[
			[tr("TRZULARD1_1A1"),["GOTO_2"]],
			[tr("TRZULARD1_1A2"),["END"]]
			]
		},
	"2":
		{"Text":tr("TRZULARD1_2"), 
		"Answers":[
			[tr("TRENDCONVERSATION"),["ADDTOPARTY_ZULAR","NEGLECT_ZULAR","KILLNPC_ZULAR","END"]]
			]
		}

		},

"ASAN1":
	{"1":
		{"Text":tr("TRASAND1_1"), 
		"Answers":[
			[tr("..."),["GOTO_2"]],
			]
		},
	"2":
		{"Text":tr("TRASAND1_2"), 
		"Answers":[
			[tr("TRASAND1_2A1"),["GOTO_3"]]
			]
		},
	"3":
		{"Text":tr("TRASAND1_3"), 
		"Answers":[
			[tr("TRASAND1_3A1"),["GOTO_4"]]
			]
		},
	"4":
		{"Text":tr("TRASAND1_4"), 
		"Answers":[
			[tr("TRASAND1_4A1"),["EVENT_D2", "END"]]
			]
		}

		}
		
		
		}
		
var dialogue = "ALI1"
var line

var button = preload("res://Answer.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Speaker1.text =tr("TR"+speaker1)
	$Speaker2.text =tr("TR"+speaker2)
	$Speaker1.visible_characters = 0
	$Speaker2.visible_characters = 0
	$Tween.interpolate_property($Speaker1, "visible_characters", 0, $Speaker1.text.length()+1,0.4)
	$Tween.interpolate_property($Speaker2, "visible_characters", 0, $Speaker2.text.length()+1,0.4)
	$Tween.start()
	$TextureRect.texture = load("res://Sprites/ANIMS/"+speaker1+".tres")
	$TextureRect2.texture = load("res://Sprites/ANIMS/"+speaker2+".tres")
	start("1")
	pass # Replace with function body.

func start(firstphrase):
	$Label.text = dialogues[dialogue][firstphrase]["Text"]
	line = firstphrase
	$Label.visible_characters = 0
	$Tween2.interpolate_property($Label,"visible_characters", 0, $Label.text.length()+1,1)
	$Tween2.start()
	for x in dialogues[dialogue][line]["Answers"]:
		var i = button.instance()
		i.text = x[0]
		i.effects = x[1]
		$VBoxContainer.add_child(i)
	pass
func speak(phrase):
	for x in $VBoxContainer.get_children():
		x.queue_free()
	$Label.text = dialogues[dialogue][phrase]["Text"]
	line = phrase
	$Label.visible_characters = 0
	$Tween2.interpolate_property($Label,"visible_characters", 0, $Label.text.length()+1,1)
	$Tween2.start()
	for x in dialogues[dialogue][line]["Answers"]:
		var i = button.instance()
		i.text = x[0]
		i.effects = x[1]
		$VBoxContainer.add_child(i)
	pass
func effect(eff):
	match eff.split("_")[0]:
		"ADDTOPARTY":
			Data.party.append(Data.potential_members[eff.split("_")[1]].duplicate(true))
		"GOTO":
			speak(eff.split("_")[1])
		"NEGLECT":
			for x in get_tree().get_nodes_in_group("NPC"):
				if x.character == eff.split("_")[1]:
					x.need_dialogue = false
					break
		"KILLNPC":
			for x in get_tree().get_nodes_in_group("NPC"):
				if x.character == eff.split("_")[1]:
					x.queue_free()
		"END":
			queue_free()
		"EVENT":
			Data.events.append(eff.split("_")[1])
			Save.savegame()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
