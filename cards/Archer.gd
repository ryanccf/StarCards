extends "res://scripts/card.gd"
const Archer = preload("res://monsters/Archer.tscn")

func _ready():
#	.ready()
	monster = Archer.instance()
