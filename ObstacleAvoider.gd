extends Node2D

var _last_rotation
var _rotation_timeout = 10000
var _current_time = 0

func _process(delta):
	if _current_time <= _rotation_timeout:
		_current_time += 100 * delta * 80
	else:
		_current_time = float(int(_current_time) % int(100 * delta * 80))
		_last_rotation = null

func add_exception(body):
	for tracker in get_children():
		tracker.add_exception(body)

func get_viable_rotation():
	if not _last_rotation:
		_last_rotation = _pick_rotation()
	return _last_rotation
	
func _pick_rotation():
	for tracker in get_children():
		if tracker.empty():
			return tracker.rotation
