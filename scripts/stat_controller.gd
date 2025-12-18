extends Node2D

var gameController : Node2D

# core systems
var level : int = 0
var playerXp : float = 0.0

var levelModifier : float = 1.2
var baseIncrease : int = 1
var statIncrease : int = 0

var levelXp : float = 10

# player values
var health : int = 5
var mana : int = 10

func _ready() -> void:
    gameController = get_tree().get_first_node_in_group("gamecontroller")
    gameController.emitXp.connect(increaseXp)

    statIncrease = baseIncrease

func increaseXp(amount : float) -> void:
    print(playerXp)
    playerXp += amount
    print(playerXp)

    if playerXp >= levelXp:
        var remainder : float
        if playerXp > levelXp:
            remainder = playerXp - levelXp
        else:
            remainder = 0
        #print(remainder)
        levelUp(remainder)

func levelUp(remainder : float) -> void:
    # level up
    level += 1
    playerXp = 0 + remainder
    print("level up")

    # increase stats
    health += statIncrease
    mana += statIncrease  * 2

    # make next level up better
    statIncrease += 1
    # increase xp for next level
    levelXp = levelXp * levelModifier

