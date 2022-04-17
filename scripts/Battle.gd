extends Control

var card_id_counter = 0
var CardBack =  load("res://card-images/card_back.png")
var playerOneGraphic = load("res://images/ship.png")
var PlayerCharacter = preload("res://PlayerCharacter.tscn")
var opponent = preload("res://Opponent.tscn").instance()
var selected = false 
var player = PlayerCharacter.instance()
var enemy_base
var game_over = false

func _ready():
	randomize()
	initialize_cards()
	initialize_player()
	initialize_opponent()

func _process(delta):
	check_battle_end()

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

func initialize_player():
	player.increase_speed(25)
	player.update_graphic(playerOneGraphic)
	player.position = Vector2(100, 300)
	player.connect("turn_complete", self, "_on_PlayerCharacter_turn_over")
	player.connect("death", self, "_clean_up_player")
	$Background/BackgroundAnchor/Field.add_child(player)

func initialize_opponent():
	opponent.set_spawn($Background/BackgroundAnchor/Field/SpawnPoint)
	opponent.set_enemy_base(player)
	opponent.connect("spawn_monster", $Background/BackgroundAnchor/Field, "add_monster")
	add_child(opponent)

func check_battle_end():
	if not opponent.has_base():
		get_tree().change_scene("res://Victory.tscn")
	elif game_over:
		get_tree().change_scene("res://Defeat.tscn")

func _on_PlayerCharacter_turn_over():
	if ($Background/BackgroundAnchor/Hand.card_count() < 7):
		draw_card()

func _clean_up_player():
	game_over = true;

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

func _on_DeployZone_input_event(viewport, event, shape_idx):
	if _is_utility_card_ready(event):
		_play_utility_card_selected(event.position)
	elif _is_card_ready(event):
		_play_monster_card_selected(event.position)

func _on_ZoneOfInfluence_input_event(viewport, event, shape_idx):
	if _is_utility_card_ready(event):
		_play_utility_card_selected(event.position)

func _is_utility_card_ready(event):
	return _is_card_ready(event) and $Background/BackgroundAnchor/Hand.get_selected().has_method("utility_action")

func _is_card_ready(event):
	return event is InputEventMouseButton and event.pressed and $Background/BackgroundAnchor/Hand.has_selected()

func _play_utility_card_selected(event_position):
	var card = _play_card()
	var action = card.utility_action()
	$Background/BackgroundAnchor/Field.add_child(action)
	action.set_position(event_position - $Background/BackgroundAnchor/ZoneOfInfluence.global_position)

func _play_monster_card_selected(event_position):
	var card = _play_card()
	card.reset_monster()
	var monster = card.get_monster()
	monster.set_friendly()
	monster.set_target(opponent.get_base())
	monster.set_enemy_base(opponent.get_base())
	$Background/BackgroundAnchor/Field.add_monster(monster, event_position - $Background/BackgroundAnchor/DeployZone.global_position)

func _play_card():
	var card = $Background/BackgroundAnchor/Hand.pop_selected()
	$Background/BackgroundAnchor/Discard.add_card(card)
	return card
