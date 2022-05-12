extends Node

var Decklist = preload("res://Utilities/Decklist.tscn")

var ArcherCard = preload("res://Cards/ArcherCard.tscn")
var BarbarianCard = preload("res://Cards/BarbarianCard.tscn")
var BishopCard = preload("res://Cards/BishopCard.tscn")
var BlockerCard = preload("res://Cards/BlockerCard.tscn")
var DefenderCard = preload("res://Cards/DefenderCard.tscn")
var HomingMissileCard = preload("res://Cards/HomingMissileCard.tscn")
var WarriorCard = preload("res://Cards/WarriorCard.tscn")
var WedgeCard = preload("res://Cards/WedgeCard.tscn")
var ScoopCard = preload("res://Cards/ScoopCard.tscn")

var AmplifyDamageCard = preload("res://Cards/AmplifyDamageCard.tscn")
var DirectAttackCard = preload("res://Cards/DirectAttackCard.tscn")
var RepairCard = preload("res://Cards/RepairCard.tscn")

var CardListing = preload("res://CardListings/CardListing.tscn")
var BishopCardListing = preload("res://CardListings/BishopCardListing.tscn")
var ArcherCardListing = preload("res://CardListings/ArcherCardListing.tscn")
var BarbarianCardListing = preload("res://CardListings/BarbarianCardListing.tscn")
var BlockerCardListing = preload("res://CardListings/BlockerCardListing.tscn")
var DefenderCardListing = preload("res://CardListings/DefenderCardListing.tscn")
var HomingMissileCardListing = preload("res://CardListings/HomingMissileCardListing.tscn")
var WedgeCardListing = preload("res://CardListings/WedgeCardListing.tscn")
var ScoopCardListing = preload("res://CardListings/ScoopCardListing.tscn")

var AmplifyDamageCardListing = preload("res://CardListings/AmplifyDamageCardListing.tscn")
var DirectAttackCardListing = preload("res://CardListings/DirectAttackCardListing.tscn")
var RepairCardListing = preload("res://CardListings/RepairCardListing.tscn")

var SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

var canonicalCardMap = {
	"Archer" : {
		"card" : ArcherCard,
		"card_listing" : ArcherCardListing
	},
	"Barbarian" : {
		"card" : BarbarianCard,
		"card_listing" : BarbarianCardListing
	},
	"Bishop": {
		"card": BishopCard,
		"card_listing": BishopCardListing
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
	"Wedge" : {
		"card" : WedgeCard,
		"card_listing" : WedgeCardListing
	},
	"Scoop" : {
		"card" : ScoopCard,
		"card_listing" : ScoopCardListing
	},
	"AmplifyDamage" : {
		"card" : AmplifyDamageCard,
		"card_listing" : AmplifyDamageCardListing
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

var player_name = "Player"
var player_color = Color( 0.37, 0.62, 0.63, 1 )
var decks = []
var cards = Decklist.instance()
var player_position
var target_position
var current_save_index = 0
var save_slots = []
var map = null

func set_player_name(new_name):
	player_name = new_name
	store_save_data()

func get_player_name():
	return player_name

func set_player_color(new_color):
	player_color = new_color
	store_save_data()

func get_player_color():
	return player_color

func get_decks():
	return decks

func get_cards():
	return cards.get_cards()

func add_card(card_name):
	cards.add_card(card_name)
	store_save_data()
	
func get_canonical_card_list():
	return canonicalCardMap.keys()

func get_card(card_name):
	return canonicalCardMap[card_name].card.instance()

func get_card_listing(card_name):
	return canonicalCardMap[card_name].card_listing.instance()

func initialize():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var new_decklist = Decklist.instance()
	new_decklist.add_card("Repair")
	new_decklist.add_card("DirectAttack")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Defender")
	new_decklist.add_card("Bishop")
	new_decklist.add_card("Barbarian")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("Warrior")
	new_decklist.add_card("HomingMissile")
	new_decklist.add_card("Blocker")
	new_decklist.add_card("Wedge")
	new_decklist.add_card("Scoop")
	new_decklist.add_card("AmplifyDamage")
	decks.push_back(new_decklist)
	cards.add_card("Repair")
	cards.add_card("AmplifyDamage")
	cards.add_card("DirectAttack")
	cards.add_card("Warrior")
	cards.add_card("Defender")
	cards.add_card("Bishop")
	cards.add_card("Barbarian")
	cards.add_card("Warrior")
	cards.add_card("Warrior")
	cards.add_card("Warrior")
	cards.add_card("HomingMissile")
	cards.add_card("Blocker")
	cards.add_card("Wedge")
	cards.add_card("Scoop")

func _ready():
	initialize()

func reset_progress():
	decks = []
	cards = Decklist.instance()
	initialize()

func set_player_position(new_player_position):
	player_position = new_player_position
	store_save_data()

func get_player_position():
	return player_position

func set_target_position(new_target_position):
	target_position = new_target_position
	store_save_data()

func get_target_position():
	return target_position

func get_save_data():
	var cards_data = cards.get_cards()
	var decks_data = []
	for deck in decks:
		decks_data.push_back(deck.get_cards())
	
	return {
		"player_name" : player_name,
		"player_color" : player_color,
		"player_position" : player_position,
		"target_position" : target_position,
		"cards" : cards_data,
		"decks" : decks_data,
		"map" : map
	}

func load_save_data(data):
	set_player_name(data.player_name)
	set_player_color(data.player_color)
	set_player_position(data.player_position)
	set_target_position(data.target_position)
	set_map(data.map)
	
	cards = Decklist.instance()
	for card_name in data.cards:
		cards.add_card(card_name)
	decks = []
	for deck in data.decks:
		var decklist = Decklist.instance()
		for card_name in deck:
			decklist.add_card(card_name)
		decks.push_back(decklist)
	
func get_clean_save_data():
	load_save_data({
		"player_name" : "Player",
		"player_color" : Color( 0.37, 0.62, 0.63, 1 ),
		"player_position" : player_position,
		"target_position" : target_position,
		"cards" : [],
		"decks" : [],
		"map" : null
	})
	initialize()

func store_save_data():
	if save_slots.size() == current_save_index:
		save_slots.push_back(null)
	save_slots[current_save_index] = get_save_data()
	var file = File.new()
	file.open(save_path, file.WRITE)
	file.store_var(save_slots)
	file.close()

func retrieve_save_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			save_slots = file.get_var()
			file.close()
	return save_slots

func set_save_index(new_index):
	current_save_index = new_index

func get_next_save_index():
	return save_slots.size()
	
func load_game():
	load_save_data(save_slots[current_save_index])

func delete_save():
	save_slots.remove(current_save_index)
	var file = File.new()
	file.open(save_path, file.WRITE)
	file.store_var(save_slots)
	file.close()

func set_map(map_data):
	map = map_data
	store_save_data()

func get_map():
	if "map" in save_slots[current_save_index] and save_slots[current_save_index].map != null:
		return save_slots[current_save_index].map
