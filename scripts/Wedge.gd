extends "res://scripts/Monster.gd"
var graphic = load("res://images/Ship_C.png")
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
	speed = 40
	currentHP = maxHP
	update_hp()
	update_graphic(graphic)
	_initialize_spawn_point_marker()

func _physics_process(delta):
	._physics_process(delta)
	_check_raycast()

func _check_lasers(delta):
	pass

func _check_raycast():
	$StabilizedAnchor/RayCastDown.force_raycast_update()
	$StabilizedAnchor/RayCastUp.force_raycast_update()
	if ($StabilizedAnchor/RayCastDown.is_colliding()):
		$StabilizedAnchor/RayCastDown.get_collider()

func _initialize_spawn_point_marker():
	remove_child($SpawnPointMarker)
	get_parent().add_child($SpawnPointMarker)
	last_y_target = 9000

func _point_to_locked_target():
	var x
	var y
	x = 9000
	if friendly:
		set_target(Vector2(1200, global_position.y))
	else:
		set_target(Vector2(0, global_position.y))

func move(delta):
	var collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
	global_position = $KinematicBody2D.global_position
	$KinematicBody2D.position = Vector2(0, 0)

func _avoid_obstacles():
	pass

func _check_death():
	._check_death()
	if out_of_bounds():
		seppuku()
