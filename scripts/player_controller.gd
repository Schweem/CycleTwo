extends CharacterBody2D

signal flipped(flag : bool)

# constants
const BASE_SPEED : float = 7500.0
const JUMP_SPEED : float = -20000.0
const MAX_FALL_SPEED : float = 225

# regular vars
var speed_mult : float = 1.0

# variable jump height stuff
var jump_res : float = 3.0
var coyote_time : float = 1.0

var jump_flag : bool = false
var stored_jump : bool = false
@onready var jumpCast : RayCast2D = $floorCheck

var wall_cling : bool = false
var walljump : bool = false
var jumpCancelled : bool = false

# gravity from engine 
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var base_grav = gravity

# on ready, usually children calls
@onready var baseSprite : AnimatedSprite2D = $Sprite2D
@onready var sword : Sprite2D = $Sprite2D/SwordTest
@onready var swordPosition : float = sword.swordPosition
@onready var playerStats : Node2D = $statController

@onready var uiController = $Camera2D/uiMananger

func _physics_process(delta: float) -> void:
	# basic floor checks 
	if !is_on_floor():

		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED

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

		if stored_jump:
			print("stored jump")
			velocity.y = JUMP_SPEED * delta
			stored_jump = false

	if wall_cling == true:
		gravity = gravity / 2
	else:
		gravity = base_grav

	# Input controller handler
	handle_inputs(delta)
	# Character body fun for applying motion
	move_and_slide()

# Simple helper to keep physics process cleaner
func handle_inputs(_delta : float) -> void:
	if Input.is_action_just_pressed("draw"):
		sword.drawSword()
	
	# get direction, handle speed and apply it
	# TODO : remove redundant signal calls (ie call it once tie it to sprite flip)
	var dir = Input.get_axis("left", "right")

	# walking stuff
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
		velocity.x = dir * speed * _delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed)  * _delta

	# wall cling
	if velocity.y > 0 and is_on_wall():
		if dir != 0:
			wall_cling = true
		else:
			wall_cling = false
	else:
		wall_cling = false
		

	# simple jump, input handling 
	if Input.is_action_just_pressed("jump"):
		# is_on_floor()
		if coyote_time > 0:
			coyote_time = 0
			velocity.y = JUMP_SPEED * _delta

		if jumpCast.is_colliding() and (is_on_floor() == false):
			stored_jump = true
	
		if is_on_wall_only() and (walljump == false):
			#velocity.y = JUMP_SPEED * 0.8
			velocity = Vector2(-600, JUMP_SPEED * 0.8) * _delta
			walljump = true

	# variable jump height
	if !is_on_floor():
		if Input.is_action_just_released("jump") and (jumpCancelled == false):
			velocity.y = velocity.y / jump_res
			jumpCancelled = true

func interaction_end(body:Node2D) -> void:
	if body.is_in_group("ladder"):
		uiController.toggle_interaction()

func interaction_start(body:Node2D) -> void:
	if body.is_in_group("ladder"):
		uiController.toggle_interaction()
		print("yay")