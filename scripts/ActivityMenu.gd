extends Popup
var ActivityButton = preload("res://Utilities/ActivityButton.tscn")
var activities = []
var battle_path = "res://Battles/Battle.tscn"
const BUTTON_SPACING = 20

func add_activity(activity_name, type):
	activities.push_back({
		"name" : activity_name,
		"type" : type,
		"event" : funcref(self, "_start_battle")
	})

func _start_battle():
	get_tree().change_scene(battle_path)

func _on_Node2D_about_to_show():
	var y_offset = 0
	for activity in activities:
		var activity_button = ActivityButton.instance()
		activity_button.set_name(activity.name)
		activity_button.set_event(activity.event)
		activity_button.connect("option_selected", self, "_on_option_selected")
		$Box.add_child(activity_button)
		activity_button.rect_position = Vector2(-1.5 * activity_button.get_size().x, y_offset)
		y_offset += activity_button.get_size().y * 3 + BUTTON_SPACING

func set_battle_path(new_battle_path):
	battle_path = new_battle_path

func dehydrate():
	var dehydrated_activities = []
	for activity in activities:
		match activity.type:
			"battle" :
				dehydrated_activities.push_back({"name" : activity.name, "type" : "battle"})
	return dehydrated_activities

func rehydrate(dehydrated_activities):
	for activity in dehydrated_activities:
		match activity.type:
			"battle" :
				activities.push_back({
					"name" : activity.name,
					"type" : activity.type,
					"event" : funcref(self, "_start_battle")
				})
