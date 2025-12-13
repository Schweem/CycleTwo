## Thanks llamapixel !
## fps_counter.gd
## Purpose:
## Tracks FPS over a frame range and updates a Label with average, highest, and lowest FPS.

extends Label

# --- Exported variables ---
@export var frame_range: int = 60        # Number of frames to calculate over

# --- FPS tracking ---
var fps_buffer: Array[int] = []
var fps_buffer_index: int = 0

var average_fps: int = 0
var highest_fps: int = 0
var lowest_fps: int = 0

func _ready() -> void:
	_initialize_buffer()

func _process(delta: float) -> void:
	_update_buffer(delta)
	_calculate_fps()
	_update_label()

# --- Initialize the FPS buffer ---
func _initialize_buffer() -> void:
	if frame_range <= 0:
		frame_range = 1
	fps_buffer = []
	for i in frame_range:
		fps_buffer.append(0)
	fps_buffer_index = 0

# --- Add current frame's FPS to the buffer ---
func _update_buffer(delta: float) -> void:
	if delta == 0:
		return
	fps_buffer[fps_buffer_index] = int(1.0 / delta)
	fps_buffer_index += 1
	if fps_buffer_index >= frame_range:
		fps_buffer_index = 0

# --- Calculate average, highest, and lowest FPS ---
func _calculate_fps() -> void:
	var sum: int = 0
	var highest: int = 0
	var lowest: int = 2147483647   # Max int
	for fps in fps_buffer:
		sum += fps
		if fps > highest:
			highest = fps
		if fps < lowest:
			lowest = fps
#	average_fps = int(sum / frame_range)
#	average_fps = sum / frame_range
#	average_fps = int( floor( sum / frame_range ) ) 
	average_fps = floor(float(sum) / frame_range)
	# I would normally squash all debugger warnings
	
	highest_fps = highest
	lowest_fps = lowest

# --- Update the Label text ---
func _update_label() -> void:
	text = "FPS: %d\nHigh: %d\nLow: %d" % [average_fps, highest_fps, lowest_fps]


