extends Node2D

@export var enemy_scene : PackedScene

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var entity_count : int = 0
var max_entities : int = 15
var entity_roster : Array = []

func _ready() -> void:
    pass

func spawn_enemy() -> void:
    if enemy_scene == null:
        push_warning("Enemy not assigned")
        return

    if entity_count < max_entities:
        var enemy_instance := enemy_scene.instantiate()
        entity_roster.append(enemy_instance)

        get_tree().current_scene.add_child(enemy_instance)
        enemy_instance.global_transform = global_transform
    