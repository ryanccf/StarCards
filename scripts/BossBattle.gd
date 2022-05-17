extends "res://scripts/Battle.gd"

func _ready():
	$ContentAnchor/Battlefield.set_victory_path("res://Screens/Win.tscn")
	$ContentAnchor/Battlefield.set_opponent(preload("res://Opponents/Boss.tscn").instance())
	initialize()
