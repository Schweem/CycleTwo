extends Control

@onready var nameLabel : Label = $nameLabel
@onready var labelContent : Label = $labelContent

@onready var container : PanelContainer = $PanelContainer

@onready var choiceOne : Button = $Button
@onready var choiceTwo : Button = $Button2
@onready var choiceThree : Button = $Button3

@onready var contents : Array = [container, nameLabel, labelContent,
								choiceOne, choiceTwo, choiceThree]

var currentActor : actor = actor.new()

var index : int = 0

var choices : Array[DialougeOption] = [
	currentActor.initial_dialouge,
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	"""
	Build out UI using the actor

	Full system will assign this after dialouge interaction begins
	"""
	# assign temp values
	nameLabel.text = currentActor.actor_name
	labelContent.text = currentActor.initial_dialouge.dialouge

	# read in the first choices
	choiceOne.text = currentActor.initial_dialouge.responses[0][0]
	choiceTwo.text = currentActor.initial_dialouge.responses[1][0]
	choiceThree.text = currentActor.initial_dialouge.responses[2][0]

func _input(_event: InputEvent) -> void:
	"""
	Read in and handle keyboard inputs

	Mostly debug
	"""
	if Input.is_action_just_pressed("toggle"):
		toggle_visible()
	elif Input.is_action_just_pressed("debug"):
		_debug_conversation()

func _handle_dialouge_choice(choice : int) -> void:
	"""
	Update the index if in range, first saftey check
	and point of dialouge
	"""

	if index < len(choices):
		update_labels(choice)
	else:
		print("Out of options.")
		pass

func _debug_conversation() -> void:
	"""
	Debug function to load a test actor
	"""
	currentActor = actor.new()

func toggle_visible() -> void:
	"""
	Looks at all UI items and toggles visible
	"""
	for item in contents:
		assert(item)
		item.visible = !item.visible

func update_labels(choice : int) -> void:
	"""
	If in range, updates the dialouge choices
	based on current index of discussion
	"""

	#index = index + 1
	#print(index, len(choices))

	"""
	Hey me in the future, here is where everything stands right now.
	This is sort of kind of finally working.

	I need to use the actor class to pass dialouge options dynamically,
	this is the last part of the tree structure of it all.
	Once they are being loaded from a set actor and handled in here
	this is DONE.
	"""

	if index < len(choices):
		match choice:
			1:
				#var selection : DialougeOption = DialougeOption.new("jimbo", "tester", "1", "2", "3")
				choices[index].nextNode = currentActor.dialouge_tree[0][index]
				choices.append(choices[index].nextNode)
			2:
				#var selection : DialougeOption = DialougeOption.new("jambo", "tested", "2", "3", "1")
				choices[index].nextNode = currentActor.dialouge_tree[1][index]
				choices.append(choices[index].nextNode)
			3:
				#var selection : DialougeOption = DialougeOption.new("jan", "testing", "3", "2", "1")
				choices[index].nextNode = currentActor.dialouge_tree[2][index]
				choices.append(choices[index].nextNode)

		choices[index].advance(choices[index+1])
		index = index + 1
		print(index, len(choices))

		nameLabel.text = choices[index].speaker
		labelContent.text = choices[index].dialouge

		choiceOne.text = choices[index].responses[0][0]
		choiceTwo.text = choices[index].responses[1][0]
		choiceThree.text = choices[index].responses[2][0]
	else:
		print("Last call")
		pass

"""
These are the unique button handlers
If something special needs to happen
for a specific one, handle it here
"""
func optionOne() -> void:
	_handle_dialouge_choice(1)

func optionTwo() -> void:
	_handle_dialouge_choice(2)

func optionThree() -> void:
	_handle_dialouge_choice(3)
