extends Node2D

var active : bool
var rootPosition : Vector2 = position

var cooldown : float = 0.4

@onready var collider : CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var swordObject : Sprite2D = get_parent()

func _ready() -> void:
	#print(swordObject)
	active = false
	collider.disabled = true

func activate() -> void:
	if active == false:
		swordObject.animationPlayer.play("swing")

		active = true
		visible = true
		collider.disabled = false

		await get_tree().create_timer(0.3).timeout
		visible = false
		collider.disabled = true
		swordObject.animationPlayer.play("idle")

		await get_tree().create_timer(cooldown).timeout
		active = false
	else:
		pass
