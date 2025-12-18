extends Node2D

@export var health : int = 3
@export var defeatXp : float = 3.0
var gameController : Node2D

func _ready() -> void:
	gameController = get_tree().get_first_node_in_group("gamecontroller")

func _process(_delta) -> void:
	if health <= 0:
		destroy()

func takeDamage() -> void:
	health = health - 1
	print("ok")

func destroy() -> void:
	gameController.emitXp.emit(defeatXp)
	get_parent().queue_free()