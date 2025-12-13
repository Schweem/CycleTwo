# DEBUG Pause Toggle Controller

extends Node

var children : Array = []

func _ready() -> void:
	# Store children (labels) in array
	children = get_children()
	
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		# simple reload behavior
		if event.keycode == KEY_R and event.pressed and not event.echo:
			get_tree().reload_current_scene()
			print("Restarted")

		# Toggle Debug Menu
		if event.keycode == KEY_F1 and event.pressed and not event.echo:
			for child in children:
				child.visible = !child.visible
			print("Menu toggled")
		
		# Handle game pause
		if event.keycode == KEY_F2 and event.pressed and not event.echo:
			get_tree().paused = not get_tree().paused
			get_viewport().set_input_as_handled()

			var status : String = "Paused: %s" % [get_tree().paused]
			print(status)
