# array.gd
extends Node2D

# The object to duplicate (assign in the Inspector)
@export var object_scene: PackedScene

# Number of copies to create
@export var count: int = 10

# Distance between each copy along X
@export var spacing: float = 50.0

func _ready() -> void:
	# Validate input
	if object_scene == null:
		push_warning("No object_scene assigned.")
		return

	for i in range(count):
		# Create a new instance
		var obj = object_scene.instantiate()
		
		# Set position: increasing along +X
		obj.position = Vector2(i * spacing, 0)
		
		# Add to scene
		add_child(obj)
