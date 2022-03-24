extends "res://scripts/card.gd"
const Barbarian = preload("res://monsters/Barbarian.tscn")

func _ready():
#	.ready()
	monster = Barbarian.instance()
