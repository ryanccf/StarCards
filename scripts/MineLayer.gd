extends "res://scripts/Monster.gd"

func _ready():
	._ready()
	maxHP = 2
	speed = 10 * 100
	currentHP = maxHP
	update_hp()

func _check_lasers(delta):
	pass
	
