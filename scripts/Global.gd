extends Node

var Decklist = preload("res://Scenes/Decklist.tscn")

var player_name = "Player 1"
var decks = []

func set_player_name(new_name):
	player_name = new_name

func get_player_name():
	return player_name

func get_decks():
	return decks

func initialize():
	var new_decklist = Decklist.instance()
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Defender")
	new_decklist.add_card("Archer")
	new_decklist.add_card("Barbarian")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	decks.push_back(new_decklist)
	print(decks[0].get_cards())

func _ready():
	initialize()
