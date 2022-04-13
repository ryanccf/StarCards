extends "res://Monster.gd"
var graphic = load("res://images/enemy_B.png")
signal boom(position)

func _ready():
	._ready()
	update_graphic(graphic)
	speed = 80
	laser_max = 12000
	maxHP = 2

func _check_lasers(delta):
	if laser_charge <= laser_max:
		laser_charge += 100 * delta * 80
	elif $ShootingZone.has_target():
		laser_charge = float(int(laser_charge) % int(100 * delta * 80))
		emit_signal("boom", position)
