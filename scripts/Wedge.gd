extends "res://scripts/Monster.gd"
var graphic = load("res://images/Ship_C.png")

func _ready():
	._ready()
	maxHP = 100
	speed = 40
	currentHP = maxHP
	update_hp()
	update_graphic(graphic)

func _point_to_locked_target():
	if friendly:
		set_target(Vector2(1200, global_position.y))
	else:
		set_target(Vector2(0, global_position.y))

func move(delta):
	$RigidBody2D.gravity_scale = 0
	$RigidBody2D.apply_impulse(Vector2.ZERO, speed * delta * Vector2(cos(rotation), sin(rotation)) )#* 0.0001)#cos(rotation), sin(rotation)))
	global_position = $RigidBody2D.global_position
	$RigidBody2D.position = Vector2(0, 0)
#	rotation += $RigidBody2D.rotation 
	$RigidBody2D.rotation = 0
	
#	var collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
#	global_position = $KinematicBody2D.global_position
#	$KinematicBody2D.position = Vector2(0, 0)

func _check_death():
	._check_death()
	if out_of_bounds():
		seppuku()

func _should_move():
	return true

func _avoid_obstacles():
	pass

func _check_lasers(delta):
	pass

