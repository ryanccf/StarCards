extends "res://scripts/card.gd"
const HomingMissile = preload("res://monsters/HomingMissile.tscn")

func reset_monster():
	monster = HomingMissile.instance()
