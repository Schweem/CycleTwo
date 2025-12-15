extends Node2D

var active : bool
var rootPosition : Vector2 = position

@onready var collider : CollisionShape2D = $StaticBody2D/CollisionShape2D

func _ready() -> void:
    active = false

func activate() -> void:
    active = !active
    if active == false:
        visible = true
        collider.disabled = false
        await get_tree().create_timer(0.3).timeout
        visible = false
        collider.disabled = true
    else:
        visible = false
        collider.disabled = true