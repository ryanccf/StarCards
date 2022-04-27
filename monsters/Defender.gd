extends "res://Monsters/Monster.gd"
var defenderGraphic = load("res://images/station_C.png")
var graphic = load("res://images/ship_L.png")

func _ready():
	._ready()
	update_graphic(graphic)
	maxHP = 100
	speed = 40
	currentHP = maxHP
	update_hp()
	update_graphic(defenderGraphic)

func _check_lasers(delta):
	pass
	
