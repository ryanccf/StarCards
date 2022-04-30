extends Control

func _ready():
	get_tree().paused = false
	var deck = Global.get_decks()[0].get_cards()
	var cards = Global.get_cards()
	var used_cards = Global.get_decks()[0].get_cards()
	var total_card_count_map = {}
	var used_card_count_map = {}
	
	for card_name in Global.get_canonical_card_list():
		total_card_count_map[card_name] = 0
		used_card_count_map[card_name] = 0

	for card_name in cards:
		total_card_count_map[card_name] += 1
		
	for card_name in used_cards:
		used_card_count_map[card_name] += 1

	for card_name in total_card_count_map:
		if total_card_count_map[card_name] > 0:
			var card_listing = Global.get_card_listing(card_name)
			card_listing.connect("increment_used", self, "increment_used")
			card_listing.connect("decrement_used", self, "decrement_used")
			card_listing.set_used(used_card_count_map[card_name])
			card_listing.set_total(total_card_count_map[card_name])
			$ScrollContainer/VBoxContainer.add_child(card_listing)

func _process(delta):
	$ScrollContainer.add_constant_override("margin_bottom", rect_size.y)

func _on_ExitArea_input_event(viewport, event, shape_idx):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		Global.store_save_data()
		get_tree().change_scene("res://Screens/LevelMap.tscn")

func increment_used(card_name):
	Global.get_decks()[0].add_card(card_name)
	
func decrement_used(card_name):
	Global.get_decks()[0].remove_card(card_name)
