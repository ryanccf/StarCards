extends "res://scripts/card.gd"

var Repair = preload("res://Actions/Repair.tscn")

func _ready():
	pass

func utility_action():
	return Repair.instance()
