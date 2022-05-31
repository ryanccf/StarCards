extends "res://scripts/Monster.gd"

signal spawn_mine(position, friendly, damage)

func _ready():
	._ready()
	maxHP = 2
	speed = 10 * 100
	currentHP = maxHP
	laser_damage = 20
	update_hp()

func _check_lasers(delta):
	if laser_charge <= laser_max:
		laser_charge += 100 * delta * 80
	else:
		laser_charge = float(int(laser_charge) % int(100 * delta * 80))
		emit_signal("spawn_mine", position, friendly, laser_damage)
