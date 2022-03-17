extends Area2D

var _targets = []
var _friendly = false
var _nearest_target
signal target_leaves(target)

func set_friendly(friendliness = true):
	_friendly = friendliness
	
func _is_aligned_with(hitbox):
	return hitbox.is_friendly() == is_friendly()
	
func is_friendly():
	return _friendly

func _on_SensingZone_area_entered(area):
	if area.has_method("take_damage") and not _is_aligned_with(area):
		_targets += [area]
#		print("NEW TARGET:" + str(area))
#		print("BELONGS TO PLAYER: " + str(area.is_friendly()))
		

func _on_SensingZone_area_exited(area):
	_targets.erase(area)
	if area == _nearest_target:
		_nearest_target = null
#		print("TARGETS: " + str(_targets))
	emit_signal("target_leaves", area)

func get_nearest_target():
	if _nearest_target == null:
		_nearest_target = _targets[0]
	for target in _targets:
		if _get_distance(target) < _get_distance(_nearest_target):
			_nearest_target = target

	return _nearest_target

func has_target():
	return not _targets.empty()

func _get_distance(target):
	return global_position.distance_to(target.global_position)
	
func has_specific_target(target):
	for current_target in _targets:
		if current_target.global_position == target:
			return true
