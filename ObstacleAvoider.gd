extends Node2D

func add_exception(body):
	for tracker in get_children():
		tracker.add_exception(body)

func get_viable_rotation():
	for tracker in get_children():
		if tracker.empty():
			return tracker.rotation
