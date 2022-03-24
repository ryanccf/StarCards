extends "res://scripts/card.gd"
const Defender = preload("res://Defender.tscn")

func _ready():
#	.ready()
	monster = Defender.instance()
