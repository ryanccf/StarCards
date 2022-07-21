extends Node2D

var get_current_position

func _process(delta):
	#wrong (does not account for position being relative to solar system, not LevelMap):
	if get_current_position and get_current_position.is_valid():
	  position = get_current_position.call_func() - get_parent().get_parent().position

func set_position_getter(current_position_getter):
	get_current_position = current_position_getter
