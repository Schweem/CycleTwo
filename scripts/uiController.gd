extends Control

@onready var xpLabel : Label = $xpLabel
@onready var levelLabel : Label = $levelLabel

@onready var manaLabel : Label = $manaLabel
@onready var healthLabel : Label = $healthLabel

@onready var statController : Node2D = get_tree().get_first_node_in_group("statCon")

func _process(_delta: float) -> void:
	xpLabel.text = ("XP: %.1f / %.1f" % [statController.playerXp, statController.levelXp])
	levelLabel.text = ("Level: %.0f" % statController.level)

	manaLabel.text = ("Mana: %.1f" % statController.mana)
	healthLabel.text = ("HP: %.1f" % statController.health)
