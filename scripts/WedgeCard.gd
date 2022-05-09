extends "res://scripts/card.gd"
const Wedge = preload("res://monsters/Wedge.tscn")

func reset_monster():
	monster = Wedge.instance()
