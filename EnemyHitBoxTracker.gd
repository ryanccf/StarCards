extends Node2D

var target

func _ready():
	$SensingZone.connect("target_leaves", self, "_reaffirm_focus")
	_focus()

func _process(delta):
	if not has_target():
		_focus()
	
func _reaffirm_focus(target_leaving_SensingZone):
	if target == target_leaving_SensingZone:
		target = null
		_focus()

func _focus():
	if $SensingZone.has_target():
		target = $SensingZone.get_nearest_target()

func set_friendly(friendliness = true):
	$SensingZone.set_friendly(friendliness)

func get_locked_target():
	return target.global_position

func has_target():
	return target != null

func _get_distance(target):
	return global_position.distance_to(target.global_position)

func has_specific_target(target):
	return $SensingZone.has_specific_target(target)
