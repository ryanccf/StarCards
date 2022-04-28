extends Popup
var ActivityButton = preload("res://Utilities/ActivityButton.tscn")
var activities = []

func add_activity(activity_name, func_ref):
	activities.push_back({
		"name" : activity_name,
		"event" : func_ref
	})

func _on_Node2D_about_to_show():
	for activity in activities:
		var activity_button = ActivityButton.instance()
		activity_button.set_name(activity.name)
		activity_button.set_event(activity.event)
		activity_button.connect("option_selected", self, "_on_option_selected")
		$Box.add_child(activity_button)

#func click_button():
#	for activity in $Box.get_children():
#		activity.attempt_click()
