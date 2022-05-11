extends "res://scripts/Monster.gd"
var graphic = load("res://images/station_A.png")
var RayCastDown = load("$StabilizedAnchor/RayCastDown")
var RayCastUp = load("$StabilizedAnchor/RayCastUp")
var last_y_target

func _ready():
	$StabilizedAnchor/RayCastUp.collide_with_areas = true;
	$StabilizedAnchor/RayCastDown.collide_with_areas = true;
	$StabilizedAnchor/RayCastUp.collide_with_bodies = true;
	$StabilizedAnchor/RayCastDown.collide_with_bodies = true;
	._ready()
	maxHP = 100
	speed = 40 * 100
	currentHP = maxHP
	update_hp()
	update_graphic(graphic)
	_initialize_spawn_point_marker()

func _check_lasers(delta):
	pass

func _initialize_spawn_point_marker():
	remove_child($SpawnPointMarker)
	get_parent().add_child($SpawnPointMarker)
	last_y_target = 9000

func _point_to_locked_target():
	var x
	var y
	if out_of_bounds():
		if position.y > middle:
			y = 0
		else:
			y = 9000
		last_y_target = y
	else:
		y = last_y_target
	x = global_position.x#$SpawnPointMarker.global_position.x
	set_target(Vector2(x, y))

func _check_death():
	if currentHP <= 0:
		if(get_parent()):
			get_parent().remove_child(self)
			#get_parent().remove_child($SpawnPointMarker)
		queue_free()

func _should_move():
	return true
