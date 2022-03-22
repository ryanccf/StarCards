extends Node2D
var _exceptions = []
var _obstacles = []

func add_exception(obstacle):
	_exceptions.push_back(obstacle)

func empty():
	return _obstacles.empty()

func _on_TrackedArea_body_entered(body):
	if not _exceptions.has(body):
		_obstacles.push_back(body)

func _on_TrackedArea_body_exited(body):
	_obstacles.erase(body)
