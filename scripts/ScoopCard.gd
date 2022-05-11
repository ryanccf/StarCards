extends "res://scripts/card.gd"
const Scoop = preload("res://monsters/Scoop.tscn")

func reset_monster():
	monster = Scoop.instance()
