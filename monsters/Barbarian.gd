extends "res://Monster.gd"
var graphic = load("res://images/ship_k.png")

func _has_target():
	return $ShootingZone.has_target()

func _ready():
	update_graphic(graphic)
	speed = 80
	laser_max = 12000
	maxHP = 3

func _should_move():
	return !$ShootingZone.has_specific_target(enemy_base) and !(($ShootingZone.has_target() and laser_charge > laser_max))

func _point_to_locked_target():
	if ($ShootingZone.has_target() and laser_charge > laser_max):
		._point_to_locked_target()
	elif weakref(enemy_base).get_ref():
		current_target = enemy_base.global_position
	else:
		current_target = global_position
