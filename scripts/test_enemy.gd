extends CharacterBody2D

@export var health : int = 3
@export var defeatXp : float = 3.0
var gameController : Node2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	gameController = get_tree().get_first_node_in_group("gamecontroller")

func _process(_delta) -> void:
	if health <= 0:
		destroy()

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta

	move_and_slide()

func takeDamage() -> void:
	health = health - 1
	print("ok")

func destroy() -> void:
	gameController.emitXp.emit(defeatXp)
	get_parent().queue_free()
