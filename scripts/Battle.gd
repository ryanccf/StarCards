extends Node2D

const MAX_TURNS = 100

var turn_counter = 1
var card_id_counter = 0
var CardBack =  load("res://card-images/card_back.png")
var playerOneGraphic = load("res://psylocke_standing.png")

var Card = preload("res://Card.tscn")
var Stack = preload("res://Stack.tscn")
var PlayerCharacter = preload("res://PlayerCharacter.tscn")
var Monster = preload("res://Monster.tscn")

var selected = false 
var player = PlayerCharacter.instance()
var monsters = []

func _ready():
	randomize()
	initialize_cards()
	initialize_player()
	initialize_monsters()

func initialize_monsters():
	monsters.append(Monster.instance())
	monsters.append(Monster.instance())
	monsters[0].position.x = 200
	monsters[0].position.y = 300
	monsters[1].position.x = 200
	monsters[1].position.y = 200
	for monster in monsters:
		$Background.add_child(monster)

func initialize_player():
	player.increase_speed(25)
	player.update_graphic(playerOneGraphic)
	player.position = Vector2(800, 300)
	$Hand.position = Vector2(200, 300)
	player.connect("turn_complete", self, "_on_PlayerCharacter_turn_over")
	$Background.add_child(player)

func assign_card_id():
	card_id_counter += 1
	return card_id_counter

func initialize_cards():
	$Hand.set_offset(Vector2(105, 0))
	$Deck.set_offset(Vector2(0, 0))
	var suits = ["clubs", "diamonds", "hearts", "spades"]
	var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "ace", "jack", "king", "queen"]
	for suit in suits:
		for rank in ranks:
			var card = Card.instance()
			var card_name = rank + "_of_" + suit
			card.set_id(card_name)
			var my_filename = "res://card-images/" + card.get_id() + ".png"
			var card_texture = load(my_filename)
			card.set_image(card_texture, CardBack)
			card.flip()
			$Deck.add_card(card)
	$Deck.shuffle()

func draw_card():
	var card = $Deck.draw_card()
	card.flip()
	$Hand.add_card(card)
	print("Card Drawn!")

func update_turn():
	turn_counter += 1
	$TurnCounter.set_text(str(turn_counter))

func check_battle_end():
	if monsters.size() == 0:
		get_tree().change_scene("res://Victory.tscn")
	elif !players_exist():
		get_tree().change_scene("res://Defeat.tscn")

func update_battle_arrays():
	for monster in monsters:
		if !is_instance_valid(monster):
			monsters.erase(monster)

func monsters_exist():
	if monsters.size() <= 0:
		return false
	else:
		return true

func players_exist():
	if player == null:
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
