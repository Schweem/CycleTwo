extends Control

@onready var playerObject : CharacterBody2D = get_parent()
var playerTalking : bool

@onready var xpLabel : Label = $CanvasLayer/level_pannel/xpLabel
@onready var levelLabel : Label = $CanvasLayer/level_pannel/levelLabel

@onready var manaLabel : Label = $CanvasLayer/main_pannel/manaLabel
@onready var healthLabel : Label = $CanvasLayer/main_pannel/healthLabel

@onready var interaction_pannel : Panel = $CanvasLayer/interaction_pannel 
@onready var interaction_text : Label = $CanvasLayer/interaction_pannel/pressE

@onready var talk_pannel : Panel = $CanvasLayer/talkBox
@onready var talk_text : Label = $CanvasLayer/talkBox/Label
@onready var talk_portrait : Sprite2D = $CanvasLayer/talkBox/Sprite2D

@onready var statController : Node2D = get_tree().get_first_node_in_group("statCon")

func _ready() -> void:
	print(playerObject)
	interaction_text.text = "Press '%s'" % InputMap.action_get_events("interact")[0].as_text().trim_suffix(" (Physical)")
	toggle_interaction()

	# dialouge box 
	talk_pannel.visible = false
	talk_text.visible = false

	# store player talking
	playerTalking = playerObject.talking

func _process(_delta: float) -> void:
	xpLabel.text = ("XP: %.1f / %.1f" % [statController.playerXp, statController.levelXp])
	levelLabel.text = ("Level: %.0f" % statController.level)

	manaLabel.text = ("Mana: %.1f" % statController.mana)
	healthLabel.text = ("HP: %.1f" % statController.health)

func toggle_interaction() -> void:
	print('pannel flipped')
	interaction_pannel.visible = !interaction_pannel.visible

func toggle_dialouge(dialouge : Array[String], index : int = 0) -> void:
	
	if playerObject.talking == false:
		print('dialouge toggle 1')
		playerObject.talking = true
		# If there is dialouge, pass it
		if dialouge[0] != "":
			talk_text.text = dialouge[index]

		# otherwise (and always) toggle the pannels
		talk_portrait.visible = !talk_portrait.visible
		talk_pannel.visible = !talk_pannel.visible
		talk_text.visible = !talk_text.visible

	elif playerObject.talking == true:
		print('dialouge toggle 2')
		talk_text.text = dialouge[index]
		print(index)

func end_dialouge() -> void:
	talk_portrait.visible = !talk_portrait.visible
	talk_pannel.visible = !talk_pannel.visible
	talk_text.visible = !talk_text.visible

	playerObject.talking = false
