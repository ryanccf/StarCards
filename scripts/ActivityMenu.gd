extends Popup

func _ready():
#	popup()
	pass

func _on_Control_about_to_show():
	print("About to show")

func _on_Control_popup_hide():
	print("Hiding")
