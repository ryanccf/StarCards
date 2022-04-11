extends Node

var Decklist = preload("res://Scenes/Decklist.tscn")

var player_name = "Player 1"
var decks = []
var cards = Decklist.instance()

func set_player_name(new_name):
	player_name = new_name

func get_player_name():
	return player_name

func get_decks():
	return decks

func get_cards():
	return cards.get_cards()

func add_card(card_name):
	cards.add_card(card_name)
	
func get_canonical_card_list():
	return ["Archer", "Barbarian", "Defender", "Warrior"]

func initialize():
	var new_decklist = Decklist.instance()
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Defender")
	#new_decklist.add_card("Archer")
	new_decklist.add_card("Barbarian")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	decks.push_back(new_decklist)
	cards.add_card("Warrior")
	cards.add_card("Defender")
	#cards.add_card("Archer")
	cards.add_card("Barbarian")
	cards.add_card("Warrior")
	cards.add_card("Warrior")
	cards.add_card("Warrior")

func _ready():
	initialize()

func reset_progress():
	decks = []
	cards = Decklist.instance()
	initialize()
