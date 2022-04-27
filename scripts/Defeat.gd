extends "res://scripts/TextureStretcher.gd"

func _ready():
	pass # Replace with function body.

func _process(_delta):
	check_click()

func check_click():
	if Input.is_action_pressed("click"):
		Global.delete_save()
		get_tree().change_scene("res://Screens/Title.tscn")
