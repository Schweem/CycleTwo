extends Node2D

@export var enemy_scene : PackedScene

var entity_count : int = 0
var max_entities : int = 15
var entity_roster : Array = []

var respawn_delay : float = 2.5

func _ready() -> void:
	if enemy_scene == null:
		push_warning("Enemy not assigned")
		return	

func _process(_delta):
	if entity_count < max_entities:
		await get_tree().create_timer(respawn_delay).timeout
		spawn_enemy()

func spawn_enemy() -> void:
	if enemy_scene == null:
		push_warning("Enemy not assigned")
		return

	if entity_count < max_entities:
		var enemy_instance := enemy_scene.instantiate()

		entity_roster.append(enemy_instance)
		entity_count += 1

		get_tree().current_scene.add_child(enemy_instance)
		enemy_instance.global_transform = global_transform

func remove_enemy(id) -> void:
	print(id)
	
	for item in entity_roster:
		if item == id:
			print("Removed %s from roster" % item)

	entity_count -= 1
	print(entity_count)
