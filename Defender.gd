extends "res://Monster.gd"

func _ready():
	._ready()
	maxHP = 100 
	currentHP = maxHP
	update_hp()

func _check_lasers(delta):
	pass
	
