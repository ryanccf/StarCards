extends Button
var activity_event

func set_name(activity_name):
	text = activity_name

func set_event(func_ref):
	activity_event = func_ref

func _on_ActivityButton_pressed():
	activity_event.call_func()
