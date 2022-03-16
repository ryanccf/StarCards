extends Area2D

var monsters = []

func add_monster(monster, position):
	add_child(monster)
	monster.set_position(position)
	monster.rotation += (PI/2 * (-1 if monster.is_friendly() else 1))
