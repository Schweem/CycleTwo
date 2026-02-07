class_name actor extends Node2D

# Name of the speaker
var actor_name : String = "John:"

# Initial greeting message
var initial_dialouge : DialougeOption = DialougeOption.new(
	actor_name, "Greetings", "1", "2", "3"
)

# Array of dialouge arrays
# Each one represents a set of branches
# Index moves forward, conversation branches out based
# on choices
var dialouge_tree : Array[Array] = [
	# Default tree 1
	[DialougeOption.new(actor_name, "This was option 1", "1", "1", "3"),
	 DialougeOption.new(actor_name, "This was option 1-2", "1", "1", "3")],

	# Default tree 2
	[DialougeOption.new(actor_name, "This was option 2", "3", "2", "2"),
	 DialougeOption.new(actor_name, "This was option 2-2", "1", "1", "3")],

	# Default tree 3
	[DialougeOption.new(actor_name, "This was option 3", "2", "3", "1"),
	 DialougeOption.new(actor_name, "This was option 3-2", "1", "1", "3")]
]
