extends Area2D

var monsters = []

func add_monster(monster, position):
	add_child(monster)
	monster.set_position(position)
