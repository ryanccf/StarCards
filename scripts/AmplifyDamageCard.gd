extends "res://scripts/card.gd"

var AmplifyDamage = preload("res://Actions/AmplifyDamage.tscn")

func _ready():
	pass

func utility_action():
	return AmplifyDamage.instance()
