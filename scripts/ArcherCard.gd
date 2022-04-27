extends "res://scripts/card.gd"
const Archer = preload("res://monsters/Archer.tscn")

func reset_monster():
	monster = Archer.instance()
