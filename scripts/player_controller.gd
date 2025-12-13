extends CharacterBody2D

# constants
const BASE_SPEED : float = 200.0
const JUMP_SPEED : float = -450.0

# regular vars
var speed_mult : float = 1.0
# variable jump height stuff
var jump_res : float = 3.0

# gravity from engine 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# on ready, usually children calls
@onready var baseSprite : Sprite2D = $Sprite2D
@onready var sword : Sprite2D = $Sprite2D/SwordTest
	
func _physics_process(delta: float) -> void:
	# basic floor checks 
	if !is_on_floor():
		velocity.y += gravity * delta
	
	# Input controller handler
	handle_inputs()
	# Character body fun for applying motion
	move_and_slide()

# Simple helper to keep physics process cleaner
func handle_inputs() -> void:
	# simple jump, input handling 
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_SPEED

	# variable jump height
	if !is_on_floor():
		if Input.is_action_just_released("jump"):
			velocity.y = velocity.y / jump_res
	
	# get direction, handle speed and apply it 
	var dir = Input.get_axis("left", "right")
	if dir < 0:
		baseSprite.flip_h = true

		sword.flip_v = true
		sword.position.x = 6
	else:
		baseSprite.flip_h = false

		sword.flip_v = false
		sword.position.x = -6
	
	var speed : float = BASE_SPEED * speed_mult
	if dir:
		velocity.x = dir * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
