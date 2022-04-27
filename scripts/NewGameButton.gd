extends Button
var save_index

func _on_NewGameButton_pressed():
	Global.reset_progress()
	Global.set_save_index(save_index)
	get_tree().change_scene("res://Screens/NewGame.tscn")

func set_save_index(index):
	save_index = index
