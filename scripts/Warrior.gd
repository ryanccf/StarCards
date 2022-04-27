extends "res://scripts/Monster.gd"
var graphic = load("res://images/ship_E.png")

func _ready():
	._ready()
	update_graphic(graphic)
