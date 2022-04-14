extends "res://scripts/card.gd"
const Blocker = preload("res://monsters/Blocker.tscn")

func reset_monster():
	monster = Blocker.instance()
