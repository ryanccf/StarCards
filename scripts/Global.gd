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

var player_name = "Player"
var player_color = Color( 0.37, 0.62, 0.63, 1 )
var decks = []
var cards = Decklist.instance()
var player_position
var target_position

func set_player_name(new_name):
	player_name = new_name

func get_player_name():
	return player_name

func set_player_color(new_color):
	player_color = new_color

func get_player_color():
	return player_color

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
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
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

func set_player_position(new_player_position):
	player_position = new_player_position

func get_player_position():
	return player_position

func set_target_position(new_target_position):
	target_position = new_target_position

func get_target_position():
	return target_position

func get_save_data():
	return {
		"player_name" : player_name,
		"player_color" : player_color,
		"player_position" : player_position,
		"target_position" : target_position,
		"cards" : cards,
		"decks" : decks
	}

func load_save_data(data):
	set_player_name(data.player_name)
	set_player_color(data.player_color)
	set_player_position(data.player_position)
	set_target_position(data.target_position)
	cards = data.cards
	decks = data.decks

func store_save_data(data):
	var file = File.new()
	file.open(save_path, file.WRITE)
	file.store_var(get_save_data())
	file.close()
	print("The data haves a save!!")

func retrieve_save_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data
			file.close()
