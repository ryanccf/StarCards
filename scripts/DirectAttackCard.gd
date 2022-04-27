extends "res://scripts/card.gd"

var DirectAttack = preload("res://Actions/DirectAttack.tscn")

func _ready():
	pass

func utility_action():
	return DirectAttack.instance()
