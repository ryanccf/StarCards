extends Control

var card_id_counter = 0
var CardBack =  load("res://card-images/card_back.png")
var playerOneGraphic = load("res://images/ship.png")
var Card = preload("res://Card.tscn")
var DirectAttackCard = preload("res://cards/DirectAttack.tscn")
var DefenderCard = preload("res://cards/Defender.tscn")
var WarriorCard = preload("res://cards/Warrior.tscn")
var ArcherCard = preload("res://cards/Archer.tscn")
var BarbarianCard = preload("res://cards/Barbarian.tscn")
var Stack = preload("res://Stack.tscn")
var PlayerCharacter = preload("res://PlayerCharacter.tscn")
var Warrior = preload("res://monsters/Warrior.tscn")
var Archer = preload("res://monsters/Archer.tscn")
var Defender = preload("res://monsters/Defender.tscn")
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
	if ($Background/BackgroundAnchor/Hand.card_count() < 7):
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
	monsters[1].set_target(player)
	opponent.set_base({"position" : Vector2(1100, 401)})
	opponent.set_enemy_base(player)
	opponent.connect("spawn_monster", $Background/BackgroundAnchor/Field, "add_monster")
	
	add_child(opponent)
	for monster in monsters:
		monster.set_enemy_base(player)
		monster.set_color(Color(20,0,0))
		$Background/BackgroundAnchor/Field.add_monster(monster, monster.position)

func initialize_player():
	player.increase_speed(25)
	player.update_graphic(playerOneGraphic)
	player.position = Vector2(100, 300)
	player.connect("turn_complete", self, "_on_PlayerCharacter_turn_over")
	player.connect("death", self, "_clean_up_player")
	$Background/BackgroundAnchor/Field.add_child(player)

func assign_card_id():
	card_id_counter += 1
	return card_id_counter

func initialize_cards():
	$Background/BackgroundAnchor/Hand.set_offset(Vector2(105, 0))
	$Background/BackgroundAnchor/Hand.set_selectable(true)
	$Background/BackgroundAnchor/Deck.set_offset(Vector2(0, 0))
	var deck = Global.get_decks()[0].get_cards()
	var card
	for card_name in deck:
		card = Global.get_card(card_name)
		card.set_id(card_name)
		var my_filename = "res://card-images/card_front.png"
		var card_texture = load(my_filename)
		card.set_image(card_texture, CardBack)
		card.flip()
		$Background/BackgroundAnchor/Deck.add_card(card)
	$Background/BackgroundAnchor/Deck.shuffle()

func draw_card():
	var card = $Background/BackgroundAnchor/Deck.draw_card()
	if not card:
		reshuffle()
		card = $Background/BackgroundAnchor/Deck.draw_card()
	if card:
		card.flip()
		$Background/BackgroundAnchor/Hand.add_card(card)

func reshuffle():
	for _i in range($Background/BackgroundAnchor/Discard.card_count()):
		var discarded_card = $Background/BackgroundAnchor/Discard.draw_card()
		discarded_card.flip()
		$Background/BackgroundAnchor/Deck.add_card(discarded_card)
	$Background/BackgroundAnchor/Deck.shuffle()

func discard_selected():
	$Background/BackgroundAnchor/Discard.add_card($Background/BackgroundAnchor/Hand.pop_selected())

func check_battle_end():
	var base_found
	for enemy_monster in monsters:
		if weakref(enemy_monster).get_ref() and enemy_monster.monster_type == "base":
			base_found = true
	if not base_found:
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
		if $Background/BackgroundAnchor/Hand.has_selected() and $Background/BackgroundAnchor/Hand.get_selected().has_method("utility_action"):
			var card = $Background/BackgroundAnchor/Hand.pop_selected()
			var action = card.utility_action()
			$Background/BackgroundAnchor/Field.add_child(action)
			action.set_position(event.position + $Background/BackgroundAnchor/ZoneOfInfluence.global_position)
			$Background/BackgroundAnchor/Discard.add_card(card)
			return
	if event is InputEventMouseButton and event.pressed:
		if $Background/BackgroundAnchor/Hand.has_selected():
			var card = $Background/BackgroundAnchor/Hand.pop_selected()
			$Background/BackgroundAnchor/Discard.add_card(card)
			card.reset_monster()
			var monster = card.get_monster()
			monster.set_friendly()
			for enemy_monster in monsters:
				if enemy_monster.monster_type == "base":
					monster.set_target(enemy_monster)
					monster.set_enemy_base(enemy_monster)
			$Background/BackgroundAnchor/Field.add_monster(monster, event.position - $Background/BackgroundAnchor/DeployZone.global_position)

func _on_ZoneOfInfluence_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if $Background/BackgroundAnchor/Hand.has_selected() and $Background/BackgroundAnchor/Hand.get_selected().has_method("utility_action"):
			var card = $Background/BackgroundAnchor/Hand.pop_selected()
			var action = card.utility_action()
			$Background/BackgroundAnchor/Field.add_child(action)
			action.set_position(event.position + $Background/BackgroundAnchor/ZoneOfInfluence.global_position)
			$Background/BackgroundAnchor/Discard.add_card(card)
			
