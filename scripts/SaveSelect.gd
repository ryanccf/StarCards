extends Control
const Continue = preload("res://Utilities/ContinueGameButton.tscn")
const New = preload("res://Utilities/NewGameButton.tscn")

func _ready():
	_reset()

func _reset():
	for child in $ContentAnchor/ScrollContainer/VBoxContainer.get_children():
		child.queue_free()
	var lines = Global.retrieve_save_data()
	var save_index = 0
	for line in lines:
		var button = Continue.instance()
#		button.set_data(line)
		button.connect("delete", self, "_reset")
		button.set_save_index(save_index)
		save_index += 1
		$ContentAnchor/ScrollContainer/VBoxContainer.add_child(button)
	var new_game_button = New.instance()
	new_game_button.set_save_index(lines.size())
	$ContentAnchor/ScrollContainer/VBoxContainer.add_child(new_game_button)
