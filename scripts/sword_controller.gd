extends Sprite2D

# we will use this to refer to the origin
@export var swordPosition : float = position.x
@onready var originOffset : Vector2 = offset

# these will be cleaned up and improved later
var attack_offset : Vector2 = Vector2(4.0, -11.0)
var sheathed : bool = true

func _ready() -> void:
    swordPosition = position.x

func drawSword() -> void:
    if sheathed == true:
        flip_h = true
        offset = attack_offset
        sheathed = false
    else:
        flip_h = false
        offset = originOffset
        sheathed = true
