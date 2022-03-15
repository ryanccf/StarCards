extends Area2D

func add_monster(monster, position):
	add_child(monster)
	monster.set_position(position)
