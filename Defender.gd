extends "res://Monster.gd"
var defenderGraphic = load("res://images/ship7.png")

func _ready():
	._ready()
	maxHP = 100 
	currentHP = maxHP
	update_hp()
	update_graphic(defenderGraphic)

func _check_lasers(delta):
	pass
	
