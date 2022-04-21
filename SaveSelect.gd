extends Control
const Continue = preload("res://Scenes/ContinueGameButton.tscn")
const New = preload("res://Scenes/NewGameButton.tscn")

func _ready():
	var lines = Global.retrieve_save_data()
	var save_index = 0
	print(lines)
	for line in lines:
		var button = Continue.instance()
#		button.set_data(line)
		button.set_save_index(save_index)
		save_index += 1
		$ContentAnchor/ScrollContainer/VBoxContainer.add_child(button)
	var new_game_button = New.instance()
	new_game_button.set_save_index(lines.size())
	$ContentAnchor/ScrollContainer/VBoxContainer.add_child(new_game_button)
	#$ContentAnchor/ScrollContainer/VBoxContainer.separation