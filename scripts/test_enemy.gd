extends Node2D

var health : int = 3

func _process(_delta) -> void:
	if health <= 0:
		destroy()

func takeDamage() -> void:
	health = health - 1
	print("ok")

func destroy() -> void:
	get_parent().queue_free()
