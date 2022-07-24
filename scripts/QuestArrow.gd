extends Control

var destination_position
var player_position
var zoom
var arrow_id

func set_destination_position(position):
	destination_position = position

func set_player_position(position):
	player_position = position

func set_zoom(zoom_level):
	zoom = zoom_level

func set_name(arrow_name):
	arrow_id = arrow_name

func get_name():
	return arrow_id

func _process(_delta):
	#position = get_current_position.call_func() - get_parent().get_parent().position
	#position = _get_nearest_position_on_screen()
	rect_position = get_parent().to_local(_get_nearest_position_on_screen())
	pass 

func _get_nearest_position_on_screen():
	var target_position = destination_position
	var window_area = OS.get_window_safe_area()
	window_area.position = player_position
	window_area.size *= zoom
	window_area.position -= window_area.size / 2
	
	#window_area.position += window_area.size * 0.2
	#window_area.end -= window_area.size * 0.2
	
	if window_area.has_point(target_position):
		return target_position
	else:
		var point
		var angle_to_target = player_position.angle_to_point(target_position)
		var angle_to_lower_right_corner = player_position.angle_to_point(window_area.end)
		var angle_to_lower_left_corner = player_position.angle_to_point(Vector2(window_area.position.x, window_area.end.y))
		var angle_to_upper_left_corner = player_position.angle_to_point(window_area.position)
		var angle_to_upper_right_corner = player_position.angle_to_point(Vector2(window_area.end.x, window_area.position.y))

		if angle_to_target == angle_to_lower_right_corner:
			point = window_area.end
		elif angle_to_target == angle_to_lower_left_corner:
			point = Vector2(window_area.position.x, window_area.position.y)
		elif angle_to_target == angle_to_upper_left_corner:
			point = window_area.position
		elif angle_to_target == angle_to_upper_right_corner:
			point = Vector2(window_area.end.x, window_area.position.y)

		elif angle_to_target < angle_to_lower_right_corner or angle_to_target > angle_to_upper_right_corner:
			var small_adjacent = window_area.end.x - player_position.x
			var big_adjacent = target_position.x - player_position.x
			var ratio = small_adjacent / big_adjacent
			var big_opposite = target_position.y - player_position.y
			var y = player_position.y + (ratio * big_opposite)
			point = Vector2(window_area.end.x, y)
		elif angle_to_target < angle_to_lower_left_corner:
			var small_adjacent = window_area.end.y - player_position.y
			var big_adjacent = target_position.y - player_position.y
			var ratio = small_adjacent / big_adjacent
			var big_opposite = target_position.x - player_position.x
			var x = player_position.x + (ratio * big_opposite)
			point = Vector2(x, window_area.end.y)
		elif angle_to_target < angle_to_upper_left_corner:
			var small_adjacent = window_area.position.x - player_position.x
			var big_adjacent = target_position.x - player_position.x
			var ratio = small_adjacent / big_adjacent
			var big_opposite = target_position.y - player_position.y
			var y = player_position.y + (ratio * big_opposite)
			point = Vector2(window_area.position.x, y)
		else:
			var small_adjacent = window_area.position.y - player_position.y
			var big_adjacent = target_position.y - player_position.y
			var ratio = small_adjacent / big_adjacent
			var big_opposite = target_position.x - player_position.x
			var x = player_position.x + (ratio * big_opposite)
			point = Vector2(x, window_area.position.y)
		return point
