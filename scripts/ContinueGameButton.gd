extends Button
var save_index
signal delete

func set_save_index(index):
	save_index = index
	Global.set_save_index(index)
	Global.load_game()
	$PlayerName.text = Global.get_player_name()

func _on_ContinueGameButton_pressed():
	Global.set_save_index(save_index)
	Global.load_game()
	get_tree().change_scene("res://Screens/LevelMap.tscn")

func _on_TextureButton_pressed():
	Global.set_save_index(save_index)
	Global.delete_save()
	emit_signal("delete")
