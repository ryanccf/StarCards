extends "res://scripts/card.gd"
const Warrior = preload("res://monsters/Warrior.tscn")

func _ready():
#	.ready()
	monster = Warrior.instance()
