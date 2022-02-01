extends Node2D

var turn_counter = 1
var card_id_counter = 0
const MAX_TURNS = 10

var Card = preload("res://Card.tscn")
var Stack = preload("res://Stack.tscn")
var PlayerCharacter = preload("res://PlayerCharacter.tscn")
var Monster = preload("res://Monster.tscn")

var selected = false
var deck = Stack.instance()
var hand = Stack.instance()  
var players = []
var monsters = []

onready var Count = $Background/Count

func _ready():
	randomize()
	initial_state()
	initialize_players()
	initialize_monsters()

func initialize_monsters():
	monsters.append(Monster.instance())
	monsters.append(Monster.instance())
	monsters[0].position.x = 4
	monsters[0].position.y = 18
	monsters[1].position.x = 5
	monsters[1].position.y = 22
	for monster in monsters:
		$Background.add_child(monster)

func initialize_players():
	players.append(PlayerCharacter.instance())
	players.append(PlayerCharacter.instance())
	players[0].position.x = 35
	players[0].position.y = 18
	players[1].position.x = 34
	players[1].position.y = 22
	for player in players:
		$Background.add_child(player)

func assign_card_id():
	card_id_counter += 1
	return card_id_counter

func initial_state():
	var suits = ["clubs", "diamonds", "hearts", "spades"]
	var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "ace", "jack", "king", "queen"]
	for suit in suits:
		for rank in ranks:
			var card = Card.instance()
			var card_name = rank + "_of_" + suit
			card.set_id(card_name)
			var my_filename = "res://card-images/" + card.get_id() + ".png"
			card.load_texture(my_filename)
			deck.add_card(card)
	deck.shuffle()

func update_turn():
	turn_counter += 1
	$Background/TurnCounter.set_text(str(turn_counter))

func check_turn_limit():
	if turn_counter >= MAX_TURNS:
		exit_battle()

func exit_battle():
	get_tree().change_scene("res://LevelMap.tscn")

func _on_TurnButton_pressed():
	update_turn()
	$Background.add_child(deck.draw_card())
	
func _process(delta):
	check_turn_limit()
