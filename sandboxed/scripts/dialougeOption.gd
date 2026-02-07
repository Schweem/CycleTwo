class_name DialougeOption extends Node

# Name for the speaker
# and what they have to say
var speaker : String
var dialouge : String

# to avoid stack overflow we init values as null
# need a vessel to populate these DYNAMICALLY
# currently its loaded

# Options for speaking
var responses : Array = [
	[null, null],
	[null, null],
	[null, null]
]

# Resulting Dialouge Options
var outcomes : Array[DialougeOption] = [
	null,
	null,
	null
]

var nextNode : DialougeOption

func _init(speakername : String = "John Test:", message : String = "Something",
			option1 : String = "Hi", option2 : String = "Bye.", option3 : String = "...") -> void:
	"""
	Build a starter conversation
	This is to be overwritten.

	Functions as a constructor
	"""

	speaker = speakername
	dialouge = message

	responses[0][0] = option1
	responses[1][0] = option2
	responses[2][0] = option3

func advance(next : DialougeOption) -> void:
	"""
	Consume values from next node and then
	remove reference.

	asserting first for saftey.
	"""

	assert(nextNode)

	speaker = next.speaker
	dialouge = next.dialouge

	responses = next.responses
	outcomes = next.outcomes

	nextNode = null
