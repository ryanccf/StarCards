extends Node2D

func _ready():
	pass # Replace with function body.

func _process(_delta):
	check_click()

func check_click():
	if Input.is_action_pressed("click"):
		get_tree().change_scene("res://Title.tscn")