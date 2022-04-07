extends Node2D

var deck_name = "default"
var cards = []

func add_card(card):
	cards.push_back(card)

func get_cards():
	return cards

func remove_card(name_of_card):
	cards.erase(name_of_card)

func _ready():
	pass
