extends Control

var CardListing = preload("res://Scenes/CardListing.tscn")
var ArcherCardListing = preload("res://Scenes/ArcherCardListing.tscn")
var BarbarianCardListing = preload("res://Scenes/BarbarianCardListing.tscn")
var DefenderCardListing = preload("res://Scenes/DefenderCardListing.tscn")
var DirectAttackCardListing = preload("res://Scenes/DirectAttackCardListing.tscn")

func _ready():
	var deck = Global.get_decks()[0].get_cards()
	var cards = Global.get_cards()
	var used_cards = Global.get_decks()[0].get_cards()
	
	var total_card_count_map = {
		"Archer" : 0,
		"Barbarian" : 0,
		"Defender" : 0,
		"Warrior" : 0,
		"DirectAttack" : 0
	}
	
	var used_card_count_map = {
		"Archer" : 0,
		"Barbarian" : 0,
		"Defender" : 0,
		"Warrior" : 0,
		"DirectAttack" : 0
	}

	for card_name in cards:
		total_card_count_map[card_name] += 1
		
	for card_name in used_cards:
		used_card_count_map[card_name] += 1

	
	for card_name in total_card_count_map:
		if total_card_count_map[card_name] > 0:
			var card_listing
			if card_name == "Archer":
				card_listing = ArcherCardListing.instance()
			elif card_name == "Barbarian":
				card_listing = BarbarianCardListing.instance()
			elif card_name == "Defender":
				card_listing = DefenderCardListing.instance()
			elif card_name == "Warrior":
				card_listing = CardListing.instance()
			elif card_name == "DirectAttack":
				card_listing = DirectAttackCardListing.instance()

			card_listing.connect("increment_used", self, "increment_used")
			card_listing.connect("decrement_used", self, "decrement_used")
			card_listing.set_used(used_card_count_map[card_name])
			card_listing.set_total(total_card_count_map[card_name])
			
			$ScrollContainer/VBoxContainer.add_child(card_listing)

func _process(delta):
	$ScrollContainer.add_constant_override("margin_bottom", rect_size.y)

func _on_ExitArea_input_event(viewport, event, shape_idx):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		get_tree().change_scene("res://LevelMap.tscn")

func increment_used(card_name):
	Global.get_decks()[0].add_card(card_name)
	
func decrement_used(card_name):
	Global.get_decks()[0].remove_card(card_name)
