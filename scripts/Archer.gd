extends "res://scripts/Monster.gd"
var graphic = load("res://images/ship_L.png")

func _ready():
	speed = 45 * 100
	laser_max = 8000 
	update_graphic(graphic)

func _has_target():
	return $ShootingZone.has_target()

func _should_move():
	return !$ShootingZone.has_target() or $SensingZone.has_target()

func move(delta):	
	if $SensingZone.has_target() and laser_charge <= laser_max:
		rotation += PI
	#var collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
	#global_position = $KinematicBody2D.global_position
	#$KinematicBody2D.position = Vector2(0, 0)
	#$KinematicBody2D.rotation = 0
	$RigidShipBody.gravity_scale = 0
	$RigidShipBody.set_velocity(speed * delta * Vector2(cos(rotation), sin(rotation)))
	#$RigidShipBody.apply_impulse(Vector2.ZERO, speed * delta * Vector2(cos(rotation), sin(rotation)) )#* 0.0001)#cos(rotation), sin(rotation)))
	global_position = $RigidShipBody.global_position
	$RigidShipBody.position = Vector2(0, 0)
	rotation += $RigidShipBody.rotation 
	$RigidShipBody.rotation = 0
