extends Area2D

func is_friendly():
	return get_parent().is_friendly()
