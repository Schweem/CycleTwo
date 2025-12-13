# DEBUG Pause Toggle Controller

extends Node

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.keycode == KEY_F2 and event.pressed and not event.echo:
            get_tree().paused = not get_tree().paused
            get_viewport().set_input_as_handled()
            print("pause")
