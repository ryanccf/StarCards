extends Button
var activity_event
var mouse_over = false

func set_name(activity_name):
	text = activity_name

func set_event(func_ref):
	activity_event = func_ref

func _on_ActivityButton_mouse_entered():
	mouse_over = true

func _on_ActivityButton_mouse_exited():
	mouse_over = false

func _unhandled_input(event):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed and mouse_over:
		mouse_over = false
		activity_event.call_func()
		
