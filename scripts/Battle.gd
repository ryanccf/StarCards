extends Control

var playerOneGraphic = load("res://images/ship_H.png")
var PlayerCharacter = preload("res://Battles/Utilities/PlayerCharacter.tscn")
var opponent = preload("res://Opponents/Opponent.tscn").instance()
var player = PlayerCharacter.instance()
var enemy_base
var game_over = false

func _ready():
	randomize()
	$BackgroundAnchor/CardMat.initialize()
	initialize_player()
	initialize_opponent()

func _process(delta):
	check_battle_end()

func initialize_player():
	player.set_color(Global.get_player_color())
	player.increase_speed(25)
	player.update_graphic(playerOneGraphic)
	player.position = Vector2(100, 300)
	player.connect("turn_complete", $BackgroundAnchor/CardMat, "attempt_draw")
	player.connect("death", self, "_clean_up_player")
	$BackgroundAnchor/Field.add_child(player)

func initialize_opponent():
	opponent.set_spawn($BackgroundAnchor/Field/SpawnPoint)
	opponent.set_enemy_base(player)
	opponent.connect("spawn_monster", $BackgroundAnchor/Field, "add_monster")
	add_child(opponent)

func check_battle_end():
	if not opponent.has_base():
		get_tree().change_scene("res://Screens/Victory.tscn")
	elif game_over:
		get_tree().change_scene("res://Screens/Defeat.tscn")

func _clean_up_player():
	game_over = true;

func reshuffle():
	$BackgroundAnchor/CardMat.reshuffle()

func _on_DeployZone_input_event(viewport, event, shape_idx):
	if $BackgroundAnchor/CardMat.is_utility_card_ready(event):
		_play_utility_card_selected(event.position)
	elif $BackgroundAnchor/CardMat.is_card_ready(event):
		_play_monster_card_selected(event.position)

func _on_ZoneOfInfluence_input_event(viewport, event, shape_idx):
	if $BackgroundAnchor/CardMat.is_utility_card_ready(event):
		_play_utility_card_selected(event.position)

func _play_utility_card_selected(event_position):
	var card = $BackgroundAnchor/CardMat.play_card()
	var action = card.utility_action()
	$BackgroundAnchor/Field.add_child(action)
	action.set_position(event_position - $BackgroundAnchor/ZoneOfInfluence.global_position)

func _play_monster_card_selected(event_position):
	var card = $BackgroundAnchor/CardMat.play_card()
	card.reset_monster()
	var monster = card.get_monster()
	monster.set_friendly()
	monster.set_color(Global.get_player_color())
	monster.set_target(opponent.get_base())
	monster.set_enemy_base(opponent.get_base())
	$BackgroundAnchor/Field.add_monster(monster, event_position - $BackgroundAnchor/DeployZone.global_position)
