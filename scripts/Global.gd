extends Node

var Decklist = preload("res://Scenes/Decklist.tscn")

var ArcherCard = preload("res://cards/Archer.tscn")
var BarbarianCard = preload("res://cards/Barbarian.tscn")
var DefenderCard = preload("res://cards/Defender.tscn")
var WarriorCard = preload("res://cards/Warrior.tscn")
var DirectAttackCard = preload("res://cards/DirectAttack.tscn")

var CardListing = preload("res://Scenes/CardListing.tscn")
var ArcherCardListing = preload("res://Scenes/ArcherCardListing.tscn")
var BarbarianCardListing = preload("res://Scenes/BarbarianCardListing.tscn")
var DefenderCardListing = preload("res://Scenes/DefenderCardListing.tscn")
var DirectAttackCardListing = preload("res://Scenes/DirectAttackCardListing.tscn")

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
	return ["Archer", "Barbarian", "Defender", "Warrior", "DirectAttack"]

func get_card(card_name):
	var card
	match(card_name):
		"Archer" :
			card = ArcherCard.instance()
		"Barbarian" :
			card = BarbarianCard.instance()
		"Defender" :
			card = DefenderCard.instance()
		"Warrior" : 
			card = WarriorCard.instance()
		"DirectAttack":
			card = DirectAttackCard.instance()
	return card

func get_card_listing(card_name):
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
	return card_listing

func initialize():
	var new_decklist = Decklist.instance()
	new_decklist.add_card("DirectAttack")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Defender")
	#new_decklist.add_card("Archer")
	new_decklist.add_card("Barbarian")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	decks.push_back(new_decklist)
	cards.add_card("DirectAttack")
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
