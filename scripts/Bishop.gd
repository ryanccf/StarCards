extends "res://scripts/Monster.gd"
var graphic = load("res://images/ship_J.png")

func _ready():
	._ready()
	update_graphic(graphic)
