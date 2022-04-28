extends Popup
var ActivityButton = preload("res://Utilities/ActivityButton.tscn")
var activities = []
const BUTTON_SPACING = 20

func add_activity(activity_name, func_ref):
	activities.push_back({
		"name" : activity_name,
		"event" : func_ref
	})

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

func dehydrate():
	var dehydrated_activities = []
	for activity in activities:
		match activity.name:
			"Battle" :
				dehydrated_activities.push_back({"name" : activity.name})
			"Boss Battle" :
				dehydrated_activities.push_back({"name" : activity.name})
	return dehydrated_activities

func rehydrate(dehydrated_activities):
	for activity in dehydrated_activities:
		match activity.name:
			"Battle" :
				pass
			"Boss Battle" :
				pass

