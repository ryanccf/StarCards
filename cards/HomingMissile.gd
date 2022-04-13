extends "res://scripts/card.gd"
const HomingMissile = preload("res://monsters/Boomjet.tscn")

func reset_monster():
	monster = HomingMissile.instance()
