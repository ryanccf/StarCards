extends Control


func _ready():
	pass
	
func _process(delta):
	print(rect_size.y)
	$ScrollContainer.add_constant_override("margin_bottom", rect_size.y)
	$ScrollContainer.add_constant_override("rect_size", rect_size.y)
	

func _on_ExitArea_input_event(viewport, event, shape_idx):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().change_scene("res://LevelMap.tscn")
