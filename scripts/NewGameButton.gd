extends Button
var save_index

func _on_NewGameButton_pressed():
	Global.set_save_index(save_index)
	Global.get_clean_save_data()
	Global.reset_progress()
	get_tree().change_scene("res://Screens/NewGame.tscn")

func set_save_index(index):
	save_index = index
