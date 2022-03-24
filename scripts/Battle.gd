extends Node2D

var card_id_counter = 0
var CardBack =  load("res://card-images/card_back.png")
var playerOneGraphic = load("res://images/ship.png")
var Card = preload("res://Card.tscn")
var DefenderCard = preload("res://cards/Defender.tscn")
var WarriorCard = preload("res://cards/Warrior.tscn")
var ArcherCard = preload("res://cards/Archer.tscn")
var BarbarianCard = preload("res://cards/Barbarian.tscn")
var Stack = preload("res://Stack.tscn")
var PlayerCharacter = preload("res://PlayerCharacter.tscn")
var Warrior = preload("res://Warrior.tscn")
var Archer = preload("res://monsters/Archer.tscn")
var Defender = preload("res://Defender.tscn")
var opponent = preload("res://Opponent.tscn").instance()
var selected = false 
var player = PlayerCharacter.instance()
var enemy_base
var game_over = false
var monsters = []

func _ready():
	randomize()
	initialize_cards()
	initialize_player()
	initialize_monsters()

func _on_PlayerCharacter_turn_over():
	if ($Hand.card_count() < 7):
		draw_card()

func _process(delta):
	update_battle_arrays()
	check_battle_end()

func initialize_monsters():
	monsters.append(Warrior.instance())
	monsters.append(Warrior.instance())
	monsters[0].position = Vector2(950, 200)
	monsters[1].position = Vector2(1100, 401)
	monsters[0].set_monster_type("base")
	monsters[1].set_monster_type("fighter")
	monsters[1].set_target(player.position)
	opponent.set_base({"position" : Vector2(1100, 401)})
	opponent.set_enemy_base(player.position)
	opponent.connect("spawn_monster", $Background/Field, "add_monster")
	
	add_child(opponent)
	for monster in monsters:
		monster.set_enemy_base(player.position)
		$Background/Field.add_monster(monster, monster.position)

func initialize_player():
	player.increase_speed(25)
	player.update_graphic(playerOneGraphic)
	player.position = Vector2(100, 300)
	$Hand.position = Vector2(200, 300)
	player.connect("turn_complete", self, "_on_PlayerCharacter_turn_over")
	player.connect("death", self, "_clean_up_player")
	$Background/Field.add_child(player)

func assign_card_id():
	card_id_counter += 1
	return card_id_counter

func initialize_cards():
	$Hand.set_offset(Vector2(105, 0))
	$Hand.set_selectable(true)
	$Deck.set_offset(Vector2(0, 0))
	var suits = ["clubs", "diamonds", "hearts", "spades"]
	var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "ace", "jack", "king", "queen"]
	for suit in suits:
		for rank in ranks:
			var card
			if suit == "hearts":
				card = WarriorCard.instance()
			elif suit == "spades":
				card = BarbarianCard.instance()
			elif suit == "clubs":
				card = DefenderCard.instance()
			else:
				card = ArcherCard.instance()
			card.connect("new_card_selected", self, "unselect_cards")
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
	if card:
		card.flip()
		$Hand.add_card(card)
		#else: reshuffle deck

func discard_selected():
	$Discard.add_card($Hand.pop_selected())

func check_battle_end():
	if monsters.size() == 0:
		get_tree().change_scene("res://Victory.tscn")
	elif game_over:
		get_tree().change_scene("res://Defeat.tscn")

func update_battle_arrays():
	for monster in monsters:
		if !is_instance_valid(monster):
			monsters.erase(monster)

func exit_battle():
	get_tree().change_scene("res://LevelMap.tscn")

func _clean_up_player():
	game_over = true;

func _on_DeployZone_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if $Hand.has_selected():
			var card = $Hand.pop_selected()
			$Discard.add_card(card)
			var monster = card.get_monster()
			monster.set_friendly()
			for enemy_monster in monsters:
				if enemy_monster.monster_type == "base":
					monster.set_target(enemy_monster.position)
					monster.set_enemy_base(enemy_monster.position)
			$Background/Field.add_monster(monster, event.position)
