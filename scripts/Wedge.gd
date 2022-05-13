extends "res://scripts/Monster.gd"
signal boom(position)

func _ready():
	._ready()
	maxHP = 100
	speed = 40 * 100
	currentHP = maxHP
	update_hp()
	$RigidShipBody.set_mass(10)

func _point_to_locked_target():
	if friendly:
		set_target(Vector2(1200 + 300, global_position.y))
	else:
		set_target(Vector2(0 - 300, global_position.y))

func move(delta):
	$RigidShipBody.set_velocity(speed * delta * Vector2(cos(rotation), sin(rotation)))
	$RigidShipBody.gravity_scale = 0
	global_position = $RigidShipBody.global_position
	$RigidShipBody.position = Vector2(0, 0) 
	$RigidShipBody.rotation = 0

func _check_death():
	._check_death()
	if (not is_friendly() and global_position.x < 0) or (is_friendly() and global_position.x > 1200):
		emit_signal("boom", position)
		seppuku()

func _should_move():
	return true

func _avoid_obstacles():
	pass

func _check_lasers(delta):
	pass
