extends CanvasLayer

var player_position
var zoom
var quest_arrows = []
const QuestArrow = preload("res://Utilities/QuestArrow.tscn")

func _process(_delta):
	#print($Node2D.to_local(get_parent().to_global(player_position)))
	print($Node2D.to_local($Node2D.to_global($Node2D/ColorRect.rect_position)))

func add_arrow(destination_position, name):
	var quest_arrow = QuestArrow.instance()
	quest_arrow.set_name(name)
	quest_arrow.set_destination_position(destination_position)
	quest_arrow.set_player_position(player_position)
	quest_arrow.set_zoom(zoom)
	quest_arrows.push_back(quest_arrow)
	$Node2D.add_child(quest_arrow)

func remove_arrow(name):
	for quest_arrow in quest_arrows:
		if name == quest_arrow.get_name():
			quest_arrows.remove(quest_arrow)
			$Node2D.remove_child(quest_arrow)

func set_zoom(zoom_level):
	zoom = zoom_level
	for quest_arrow in quest_arrows:
		quest_arrow.set_zoom(zoom)

func set_player_position(position):
	player_position = position
	for quest_arrow in quest_arrows:
		quest_arrow.set_player_position(position)

#func to_local(global_position):
#	return get_global_transform().affine_inverse().xform(global_position)

#func to_global(local_position):
#	return get_global_transform().xform(local_position)
