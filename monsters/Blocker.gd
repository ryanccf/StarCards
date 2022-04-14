extends "res://Monster.gd"
var graphic = load("res://images/station_A.png")
var RayCastDown = load("$StabilizedAnchor/RayCastDown")
var RayCastUp = load("$StabilizedAnchor/RayCastUp")

func _ready():
	print($StabilizedAnchor/RayCastUp)
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

func _physics_process(delta):
	._physics_process(delta)
	_check_raycast()

func _check_lasers(delta):
	pass

func _check_raycast():
	$StabilizedAnchor/RayCastDown.force_raycast_update()
	$StabilizedAnchor/RayCastUp.force_raycast_update()
	if ($StabilizedAnchor/RayCastDown.is_colliding()):
		print($StabilizedAnchor/RayCastDown.get_collider())
	elif ($StabilizedAnchor/RayCastUp.is_colliding()):
		print("Top of the screen")
