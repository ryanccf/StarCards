extends "res://scripts/Battle.gd"

func _ready():
	#$ContentAnchor/Battlefield.set_opponent(preload("res://Opponents/Boss.tscn").instance())
	$ContentAnchor/Battlefield.set_victory_path("res://Screens/Win.tscn")
	._ready()
