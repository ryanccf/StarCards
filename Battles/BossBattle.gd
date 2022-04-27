extends "res://scripts/Battle.gd"

func _ready():
	#opponent = preload("res://Opponents/Boss.tscn").instance()
	._ready()

func check_battle_end():
	if not opponent.has_base():
		get_tree().change_scene("res://Screens/Win.tscn")
	elif game_over:
		get_tree().change_scene("res://Screens/Defeat.tscn")
