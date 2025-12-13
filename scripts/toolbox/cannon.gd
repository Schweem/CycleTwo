extends Node2D

@export var projectile_scene: PackedScene	# External projectile
@export var launch_force: float = 240.0		# Magnitude of impulse
@export var min_delay: float = 2.0
@export var max_delay: float = 4.0

var _timer: Timer
# Internal timer

# ---------------------------------------------------------------------
# READY
# ---------------------------------------------------------------------
func _ready() -> void:
	# Create and configure timer
	_timer = Timer.new()
	_timer.one_shot = true
	_timer.timeout.connect(_on_fire_timeout)
	add_child(_timer)

	_schedule_next_shot()


func _schedule_next_shot() -> void:
	var t := randf_range(min_delay, max_delay)
	_timer.start(t)


# ---------------------------------------------------------------------
# Firing Logic
# ---------------------------------------------------------------------
func _on_fire_timeout() -> void:
	_fire_projectile()
	_schedule_next_shot()


func _fire_projectile() -> void:
	if projectile_scene == null:
		push_warning("Projectile scene not assigned.")
		return
	
	# Instance projectile
	var projectile := projectile_scene.instantiate()

	# Attach to scene
	get_tree().current_scene.add_child(projectile)

	# Set position and orientation at cannon origin
	projectile.global_transform = global_transform

	# Apply physics impulse straight forward (+Z)
	# Assumes projectile root is a RigidBody2D
	if projectile is RigidBody2D:
		var forward := global_transform.y
		projectile.apply_impulse(forward * launch_force)
	else:
		push_warning("Projectile scene root must be a RigidBody2D.")

