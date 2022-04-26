extends "res://scripts/card.gd"
const Bishop = preload("res://monsters/Bishop.tscn")

func reset_monster():
	monster = Bishop.instance()
