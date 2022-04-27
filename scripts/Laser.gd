extends Node2D
var speed = 110
var _target
var _target_to_right
var _target_below
var _friendly = false
signal target_reached

func set_target(position):
	_target = position
	
func set_friendly(friendliness = true):
	_friendly = friendliness
	
func is_aligned_with(node):
	if node.has_method("is_friendly"):
		return _friendly == node.is_friendly()
	
func _ready():
	_target_to_right = _target.x > global_position.x
	_target_below = _target.y > global_position.y
	
func _process(delta):
	position += speed * delta * Vector2(cos(rotation), sin(rotation))
	if _out_of_bounds():
		emit_signal("target_reached")
		queue_free()
		
func _out_of_bounds():
	return _out_of_bottom_bounds() or _out_of_top_bounds() or _out_of_right_bounds() or _out_of_left_bounds()
		
func _out_of_bottom_bounds():
	return _target_below and _target.y < global_position.y

func _out_of_top_bounds():
	return not _target_below and _target.y > global_position.y

func _out_of_right_bounds():
	return _target_to_right and _target.x < global_position.x
	
func _out_of_left_bounds():
	return not _target_to_right and _target.x > global_position.x

func _on_Area2D_area_entered(area):
	if area.has_method("take_damage") and not is_aligned_with(area):
		area.take_damage(1)
