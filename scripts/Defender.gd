extends "res://scripts/Monster.gd"
var defenderGraphic = load("res://images/station_C.png")

func _ready():
	._ready()
	maxHP = 100
	speed = 40 * 100
	currentHP = maxHP
	update_hp()
	update_graphic(defenderGraphic)

func _check_lasers(delta):
	pass
	
