extends CharacterBody2D

# constants
const BASE_SPEED : float = 200.0
const JUMP_SPEED : float = -150.0

# regular vars
var speed_mult : float = 1.0

# gravity from engine 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
func _physics_process(delta: float) -> void:
	# basic floor checks 
	if !is_on_floor():
		velocity.y += gravity * delta
		
	# simple jump, input handling 
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_SPEED
	
	# get direction, handle speed and apply it 
	var dir = Input.get_axis("left", "right")
	var speed : float = BASE_SPEED * speed_mult
	if dir:
		velocity.x = dir * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	move_and_slide()
