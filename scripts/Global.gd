extends Node

var Decklist = preload("res://Scenes/Decklist.tscn")

var ArcherCard = preload("res://cards/Archer.tscn")
var BarbarianCard = preload("res://cards/Barbarian.tscn")
var BlockerCard = preload("res://cards/Blocker.tscn")
var DefenderCard = preload("res://cards/Defender.tscn")
var HomingMissileCard = preload("res://cards/HomingMissile.tscn")
var WarriorCard = preload("res://cards/Warrior.tscn")
var DirectAttackCard = preload("res://cards/DirectAttack.tscn")
var RepairCard = preload("res://cards/RepairCard.tscn")

var CardListing = preload("res://Scenes/CardListing.tscn")
var ArcherCardListing = preload("res://Scenes/ArcherCardListing.tscn")
var BarbarianCardListing = preload("res://Scenes/BarbarianCardListing.tscn")
var BlockerCardListing = preload("res://Scenes/BlockerCardListing.tscn")
var DefenderCardListing = preload("res://Scenes/DefenderCardListing.tscn")
var HomingMissileCardListing = preload("res://Scenes/HomingMissileCardListing.tscn")
var DirectAttackCardListing = preload("res://Scenes/DirectAttackCardListing.tscn")
var RepairCardListing = preload("res://Scenes/RepairCardListing.tscn")

var canonicalCardMap = {
	"Archer" : {
		"card" : ArcherCard,
		"card_listing" : ArcherCardListing
	},
	"Barbarian" : {
		"card" : BarbarianCard,
		"card_listing" : BarbarianCardListing
	},
	"Blocker" : {
		"card" : BlockerCard,
		"card_listing" : BlockerCardListing
	},
	"Defender" : {
		"card" : DefenderCard,
		"card_listing" : DefenderCardListing
	},
	"HomingMissile" : {
		"card" : HomingMissileCard,
		"card_listing" : HomingMissileCardListing
	},
	"Warrior" : {
		"card" : WarriorCard,
		"card_listing" : CardListing
	},
	"DirectAttack" : {
		"card" : DirectAttackCard,
		"card_listing" : DirectAttackCardListing
	},
	"Repair" : {
		"card" : RepairCard,
		"card_listing" : RepairCardListing
	}
}

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
	return canonicalCardMap.keys()

func get_card(card_name):
	return canonicalCardMap[card_name].card.instance()

func get_card_listing(card_name):
	return canonicalCardMap[card_name].card_listing.instance()

func initialize():
	var new_decklist = Decklist.instance()
	new_decklist.add_card("Repair")
	new_decklist.add_card("DirectAttack")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Defender")
	#new_decklist.add_card("Archer")
	new_decklist.add_card("Barbarian")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("HomingMissile")
	new_decklist.add_card("Blocker")
	decks.push_back(new_decklist)
	cards.add_card("Repair")
	cards.add_card("DirectAttack")
	cards.add_card("Warrior")
	cards.add_card("Defender")
	#cards.add_card("Archer")
	cards.add_card("Barbarian")
	cards.add_card("Warrior")
	cards.add_card("Warrior")
	cards.add_card("Warrior")
	cards.add_card("HomingMissile")
	cards.add_card("Blocker")

func _ready():
	initialize()

func reset_progress():
	decks = []
	cards = Decklist.instance()
	initialize()
