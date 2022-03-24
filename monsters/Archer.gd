extends "res://Monster.gd"
var graphic = load("res://images/ship11.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = 45
	laser_max = 8000
	update_graphic(graphic)

func _has_target():
	return $ShootingZone.has_target()

func _should_move():
	return !$ShootingZone.has_target() or $SensingZone.has_target()

func move(delta):
	if $SensingZone.has_target():
		rotation += PI
	var collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
	global_position = $KinematicBody2D.global_position
	$KinematicBody2D.position = Vector2(0, 0)
	$KinematicBody2D.rotation = 0
