extends "res://scripts/Monster.gd"
var graphic = load("res://images/ship_J.png")

var start_rotation = 0.25 * PI
var last_rotation = start_rotation

func _ready():
	._ready()
	update_graphic(graphic)
	if position.y > middle:
		rotation = start_rotation
	else:
		rotation = -1 * start_rotation

func _physics_process(delta):
	_check_death()
	_rotate()
	if _should_move():
		rotation = last_rotation
		move(delta)
	else:
		look_at(get_target())
	_check_lasers(delta)
	_stabilize_health_bar()
	if out_of_bounds():
		_bounce()

func _bounce():
	if position.x > middle:
		rotation = start_rotation
	else:
		rotation = -1 * start_rotation
	last_rotation = rotation

func _rotate():
	_point_to_locked_target()

func move(delta):
	var collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
	if collision:
		_bounce()
	global_position = $KinematicBody2D.global_position
	$KinematicBody2D.position = Vector2(0, 0)
	rotation += $KinematicBody2D.rotation 
	$KinematicBody2D.rotation = 0
