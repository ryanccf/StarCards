extends "res://scripts/card.gd"
const Warrior = preload("res://Warrior.tscn")

func _ready():
#	.ready()
	monster = Warrior.instance()
