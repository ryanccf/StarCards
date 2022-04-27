extends "res://scripts/card.gd"
const Warrior = preload("res://monsters/Warrior.tscn")

func reset_monster():
	monster = Warrior.instance()
