extends Control

var card_name = "Warrior"
var used = 0
var total = 4
signal increment_used(card_name)
signal decrement_used(card_name)

func _ready():
	update_text()

func _on_UpArrowArea_input_event(viewport, event, shape_idx):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		increment_used()
		update_text()

func _on_DownArrowArea_input_event(viewport, event, shape_idx):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		decrement_used()
		update_text()

func increment_used():
	if used < total:
		used += 1
		emit_signal("increment_used", card_name)
	
func decrement_used():
	if used > 0:
		used -=1
		emit_signal("decrement_used", card_name)


func update_text():
	$HBoxContainer/Available.text = String(used)  + "/" + String(total)

func set_used(count):
	used = count
	
func set_total(count):
	total = count
