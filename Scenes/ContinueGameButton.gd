extends Button
var save_index

func _on_ContinueGameButton_pressed():
	Global.set_save_index(save_index)
	Global.load_game()
	get_tree().change_scene("res://LevelMap.tscn")

func set_save_index(index):
	save_index = index
