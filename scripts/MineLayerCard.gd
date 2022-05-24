extends "res://scripts/card.gd"
const MineLayer = preload("res://monsters/MineLayer.tscn")

func reset_monster():
	monster = MineLayer.instance()
