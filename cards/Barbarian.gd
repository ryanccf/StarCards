extends "res://scripts/card.gd"
const Barbarian = preload("res://monsters/Barbarian.tscn")

func reset_monster():
	monster = Barbarian.instance()
