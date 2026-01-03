extends CharacterBody2D

@export var health : int = 3
@export var defeatXp : float = 3.0
var gameController : Node2D

var dir : Vector2 = Vector2(1,0)
var move_speed : float = 2500

var detected : bool = false
var last_seen : Vector2 = Vector2(0,0)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var enemy_manager : Node2D = get_tree().get_first_node_in_group("overlord")

func _ready() -> void:
	gameController = get_tree().get_first_node_in_group("gamecontroller")

func _process(_delta) -> void:
	if health <= 0:
		destroy()

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if !is_on_wall() and (detected == false):
		velocity.x = dir.x * move_speed * delta
	
	elif !is_on_wall() and (detected == true):
		velocity.x = move_toward(position.x, to_global(last_seen).x, move_speed) * delta
	
	elif is_on_wall:
		dir.x = -dir.x

	move_and_slide()

func takeDamage() -> void:
	health = health - 1
	print("ok")

func destroy() -> void:
	enemy_manager.remove_enemy(instance_from_id(get_instance_id()))
	gameController.emitXp.emit(defeatXp)
	
	queue_free()

func _detect_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		last_seen = body.position
		
		print(last_seen)
		detected = true

func _on_detect_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") and (detected == true):
		await get_tree().create_timer(1.5).timeout
		detected = false
