extends "res://Monster.gd"
var warriorGraphic = load("res://images/ship.png")

func _ready():
	._ready()
	update_graphic(warriorGraphic)
