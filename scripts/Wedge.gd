extends "res://scripts/Monster.gd"
signal boom(position)
#var graphic = load("res://images/Ship_C.png")

func _ready():
	._ready()
	maxHP = 100
	speed = 40 * 100
	currentHP = maxHP
	update_hp()
#	update_graphic(graphic)
	$RigidShipBody.set_mass(10)

func _point_to_locked_target():
	if friendly:
		set_target(Vector2(1200 + 300, global_position.y))
	else:
		set_target(Vector2(0 - 300, global_position.y))

func move(delta):
	$RigidShipBody.set_velocity(speed * delta * Vector2(cos(rotation), sin(rotation)))
	$RigidShipBody.gravity_scale = 0
#	$RigidShipBody.apply_impulse(Vector2.ZERO, speed * delta * Vector2(cos(rotation), sin(rotation)) )#* 0.0001)#cos(rotation), sin(rotation)))
	global_position = $RigidShipBody.global_position
	$RigidShipBody.position = Vector2(0, 0)
#	rotation += $RigidShipBody.rotation 
	$RigidShipBody.rotation = 0
	
#	var collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
#	global_position = $KinematicBody2D.global_position
#	$KinematicBody2D.position = Vector2(0, 0)

func _check_death():
	._check_death()
	if out_of_bounds():
		emit_signal("boom", position)
		seppuku()

func _should_move():
	return true

func _avoid_obstacles():
	pass

func _check_lasers(delta):
	pass

