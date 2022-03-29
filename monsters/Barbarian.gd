extends "res://Monster.gd"
var graphic = load("res://images/ship_k.png")

func _has_target():
	return $ShootingZone.has_target()

# Called when the node enters the scene tree for the first time.
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
	else:
		current_target = enemy_base
