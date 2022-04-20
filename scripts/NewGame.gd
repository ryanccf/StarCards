extends Control

func _ready():
	pass

func store_data():
	Global.set_player_name($VBoxContainer/LineEdit.text)
	Global.set_player_color($VBoxContainer/ColorPicker.color)

func _on_Button_pressed():
	store_data()
	get_tree().change_scene("res://LevelMap.tscn")
