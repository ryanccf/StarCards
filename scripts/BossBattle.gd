extends "res://scripts/Battle.gd"

func _ready():
	print("CHILD READY METHOD")
	print("SET OPPONENT")
	$ContentAnchor/Battlefield.set_opponent(preload("res://Opponents/Boss.tscn").instance())
	print("SRSLY")
	$ContentAnchor/Battlefield.set_victory_path("res://Screens/Win.tscn")
	print("NOW RUN PARENT READY")
	initialize()
	print("PARENT READY DONE")
