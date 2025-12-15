extends Sprite2D

# we will use this to refer to the origin
@export var swordPosition: float = position.x
@onready var originOffset: Vector2 = offset

@onready var baseLoc : Vector2 = position
@onready var offLoc : Vector2 = abs(position)

# attack stuff
@onready var slashObject = $Slash

# these will be cleaned up and improved later
var attackOffset: Vector2 = Vector2(4.0, -11.0)
var sheathed: bool = true

func _ready() -> void:
	swordPosition = position.x
	print(baseLoc, offLoc)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()

func drawSword() -> void:
	if sheathed == true:
		z_index = 3
		flip_h = true
		offset = attackOffset
		sheathed = false
	# TODO : make this better (handle conditions more eleganelty)
	else:
		z_index = -1
		offset = Vector2(0, 0)
		flip_h = false
		sheathed = true

func attack() -> void:
	if sheathed == false:
		slashObject.activate()

#TODO : PLEASE get rid of magic numbers
func _character_flipped(flag: bool) -> void:
	# true == flipped, false == not flipped
	if (flag == true) and (sheathed == false):
		offset = abs(attackOffset)

		slashObject.flip_h = true
		slashObject.offset.x = -40
		slashObject.collider.position.x = -42

	else:
		if sheathed == false:
			slashObject.flip_h = false
			offset = attackOffset
			slashObject.offset.x = 0
			slashObject.collider.position.x = 0
		else:
			offset = Vector2(0,0)

func melee_contact(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.takeDamage()
