extends Control


func _ready():
	pass


func _on_ExitArea_input_event(viewport, event, shape_idx):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().change_scene("res://LevelMap.tscn")
