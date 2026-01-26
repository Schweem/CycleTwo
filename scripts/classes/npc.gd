class_name npc extends CharacterBody2D

@export var dialouge : Array[String] = ["Hi, I am Phil Fish. I created the game FEZ.", "Okay"]

var canTalk : bool = false
var uiManager : Control

var index : int = 0

func _ready() -> void:
	uiManager = get_tree().get_first_node_in_group("uiMan")
	print(uiManager)

func _process(_delta: float) -> void:
	move_and_slide()
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and canTalk == true:
		talk()

func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		toggle_talk()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		toggle_talk()

func toggle_talk() -> void:
	canTalk = !canTalk
	print(canTalk)
	
	uiManager.toggle_interaction()

func talk() -> void:
	if index < len(dialouge):
		uiManager.toggle_dialouge(dialouge, index)
		index += 1
	else:
		uiManager.end_dialouge()
	
	
