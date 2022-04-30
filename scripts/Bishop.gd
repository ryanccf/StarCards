extends "res://scripts/Monster.gd"
var graphic = load("res://images/ship_J.png")

var start_rotation = 0.25 * PI

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
		_avoid_obstacles()
		move(delta)
	_check_lasers(delta)
	_stabilize_health_bar()
	if out_of_bounds():
		if position.x > middle:
			rotation = start_rotation
		else:
			rotation = -1 * start_rotation
			
func _rotate():
	_point_to_locked_target()
#	look_at(get_target())

func _avoid_obstacles():
	pass
#	var path_rotation = $ObstacleAvoider.get_viable_rotation()
#	if path_rotation != null:
#		rotation += path_rotation

func move(delta):
	var collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
	global_position = $KinematicBody2D.global_position
	$KinematicBody2D.position = Vector2(0, 0)
	rotation += $KinematicBody2D.rotation 
	$KinematicBody2D.rotation = 0
	
