extends "res://scripts/card.gd"
const Defender = preload("res://monsters/Defender.tscn")

func reset_monster():
	monster = Defender.instance()
