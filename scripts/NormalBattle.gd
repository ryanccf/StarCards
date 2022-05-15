extends "res://scripts/Battle.gd"

func _ready():
	$ContentAnchor/Battlefield.set_opponent(preload("res://Opponents/Opponent.tscn").instance())
	initialize()
