extends Node2D

const MAX_TURNS = 100

var turn_counter = 1
var card_id_counter = 0
var CardBack =  load("res://card-images/pokemoncard.png")
var playerOneGraphic = load("res://psylocke_standing.png")

var Card = preload("res://Card.tscn")
var Stack = preload("res://Stack.tscn")
var PlayerCharacter = preload("res://PlayerCharacter.tscn")
var Monster = preload("res://Monster.tscn")

var selected = false 
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
	players[0].increase_speed(25)
	players[0].update_graphic(playerOneGraphic)
	players[0].scale_sprite(Vector2(0.1, 0.15))
	players[0].position.x = 35
	players[0].position.y = 18
	players[1].position.x = 34
	players[1].position.y = 22
	for player in players:
		player.connect("turn_complete", self, "_on_PlayerCharacter_turn_over")
		$Background.add_child(player)

func assign_card_id():
	card_id_counter += 1
	return card_id_counter

func initial_state():
	$Hand.set_x_offset(105)
	var suits = ["clubs", "diamonds", "hearts", "spades"]
	var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "ace", "jack", "king", "queen"]
	for suit in suits:
		for rank in ranks:
			var card = Card.instance()
			var card_name = rank + "_of_" + suit
			card.set_id(card_name)
			var my_filename = "res://card-images/" + card.get_id() + ".png"
			card.set_front_image(my_filename)
			card.set_back_image(CardBack)
			$Deck.add_card(card)
	$Deck.shuffle()

func draw_card():
	$Hand.add_card($Deck.draw_card())

func update_turn():
	turn_counter += 1
	$Background/TurnCounter.set_text(str(turn_counter))

func check_battle_end():
	if monsters.size() == 0:
		get_tree().change_scene("res://Victory.tscn")
	elif players.size() == 0:
		get_tree().change_scene("res://Defeat.tscn")

func update_battle_arrays():
	for monster in monsters:
		if !is_instance_valid(monster):
			monsters.erase(monster)
	for player in players:
		if !is_instance_valid(player):
			players.erase(player)

func monsters_exist():
	if monsters.size() <= 0:
		return false
	else:
		return true

func players_exist():
	if players.size() <= 0:
		return false
	else:
		return true

func exit_battle():
	get_tree().change_scene("res://LevelMap.tscn")

func _on_TurnButton_pressed():
	update_turn()
	draw_card()

func _on_PlayerCharacter_turn_over():
	draw_card()

func _process(delta):
	update_battle_arrays()
	check_battle_end()
