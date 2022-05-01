extends Popup
var ActivityButton = preload("res://Utilities/ActivityButton.tscn")
var activities = []
var battle_path = "res://Battles/Battle.tscn"
var destination_name
const BUTTON_SPACING = 20
signal quest(destination_name)

func add_activity(activity_name, type):
	activities.push_back({
		"name" : activity_name,
		"type" : type,
		"event" : funcref(self, "_start_battle")
	})

func add_quest(new_destination_name):
	destination_name = new_destination_name
	activities.push_back({
		"name" : "Delivery to " + destination_name,
		"destination_name" : destination_name,
		"type" : "quest",
		"event" : funcref(self, "_broadcast_quest")
	})

func add_quest_destination(origin_name):
	activities.push_back({
		"name" : "Delivery from " + origin_name,
		"type" : "reward",
		"event" : funcref(self, "_start_reward"),
		"origin_name" : origin_name
	})

func _start_battle():
	get_tree().change_scene(battle_path)

func _broadcast_quest():
	var index = 0
	_erase_activity("quest")
	emit_signal("quest", destination_name)

func _start_reward():
	_erase_activity("reward")
	get_tree().change_scene("res://Screens/Victory.tscn")

func _erase_activity(activity_type):
	var index = 0
	for activity in activities:
		if activity.type == activity_type:
			activities.erase(activity)
			$Box.remove_child($Box.get_children()[index])
		index += 1

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
			"quest" :
				dehydrated_activities.push_back({"destination_name" : activity.destination_name, "type" : "quest"})
			"reward":
				dehydrated_activities.push_back({"origin_name" : activity.origin_name, "type" : "reward"})
				
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
			"quest" :
				add_quest(activity.destination_name)
			"reward" :
				add_quest_destination(activity.origin_name)
