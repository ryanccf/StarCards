extends "res://Monster.gd"
var graphic = load("res://images/station_A.png")

func _ready():
	._ready()
	maxHP = 100
	speed = 40
	currentHP = maxHP
	update_hp()
	update_graphic(graphic)

func _check_lasers(delta):
	pass
	
