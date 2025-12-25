extends Camera2D

var move_speed : float = 0.75
var camera_distance : int = 20
var down_set : float = 1.2

func _process(delta: float) -> void:
    if Input.is_action_pressed("up"):
        look_up(delta)
    elif Input.is_action_pressed("down"):
        look_down(delta)
    else:
        reset_view(delta)


func reset_view(_delta : float) -> void:
    #print("reset")
    if offset.y > 0:
        while offset.y > 0:
            offset.y -= 1
            break
    if offset.y < 0:
        while offset.y < 0:
            offset.y += 1
            break

func look_up(_delta : float) -> void:
    #print("up")
    if offset.y > -camera_distance:
        offset.y -= move_speed

func look_down(_delta : float) -> void:
    #print("down")
    if offset.y < (camera_distance * down_set):
        offset.y += move_speed