extends CharacterBody2D

signal flipped(flag : bool)

# constants
const BASE_SPEED : float = 200.0
const JUMP_SPEED : float = -350.0

# regular vars
var speed_mult : float = 1.0

# variable jump height stuff
var jump_res : float = 3.0
var coyote_time : float = 1.0

var walljump : bool = false
var jumpCancelled : bool = false

# gravity from engine 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# on ready, usually children calls
@onready var baseSprite : AnimatedSprite2D = $Sprite2D
@onready var sword : Sprite2D = $Sprite2D/SwordTest
@onready var swordPosition : float = sword.swordPosition
@onready var playerStats : Node2D = $statController


func _physics_process(delta: float) -> void:
	# basic floor checks 
	if !is_on_floor():
		if coyote_time > 0:
			coyote_time -= 0.1
		velocity.y += gravity * delta
	else:
		# reset all the jump stuff
		# state machines would be sick right 
		if walljump == true:
			walljump = false

		if jumpCancelled == true:
			jumpCancelled = false

		if coyote_time < 1.0:
			coyote_time += 0.1

	# Input controller handler
	handle_inputs()
	# Character body fun for applying motion
	move_and_slide()

# Simple helper to keep physics process cleaner
func handle_inputs() -> void:
	if Input.is_action_just_pressed("draw"):
		sword.drawSword()
	
	# get direction, handle speed and apply it
	# TODO : remove redundant signal calls (ie call it once tie it to sprite flip)
	var dir = Input.get_axis("left", "right")
	if !is_on_wall_only():
		if dir < 0:
			baseSprite.flip_h = true
			flipped.emit(true)

			sword.flip_v = true
			sword.position.x = abs(swordPosition)
		elif dir > 0:
			baseSprite.flip_h = false
			flipped.emit(false)

			sword.flip_v = false
			sword.position.x = swordPosition
		# third case to let it linger
		else:
			baseSprite.play("idle")
			baseSprite.flip_h = baseSprite.flip_h
			sword.position.x = sword.position.x
			flipped.emit(baseSprite.flip_h)
	
	var speed : float = BASE_SPEED * speed_mult
	if dir:
		velocity.x = dir * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# simple jump, input handling 
	if Input.is_action_just_pressed("jump"):
		# is_on_floor()
		if coyote_time > 0:
			coyote_time = 0
			velocity.y = JUMP_SPEED
	
		if is_on_wall_only() and (walljump == false):
			#velocity.y = JUMP_SPEED * 0.8
			velocity = Vector2(-600, JUMP_SPEED * 0.8)
			walljump = true

	# variable jump height
	if !is_on_floor():
		if Input.is_action_just_released("jump") and (jumpCancelled == false):
			velocity.y = velocity.y / jump_res
			jumpCancelled = true

