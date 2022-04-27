extends Control

var playerOneGraphic = load("res://images/ship_H.png")
var PlayerCharacter = preload("res://Battles/Utilities/PlayerCharacter.tscn")
var opponent = preload("res://Opponents/Opponent.tscn").instance()
var player = PlayerCharacter.instance()
var enemy_base
var game_over = false

func _ready():
	randomize()
	$ContentAnchor/CardMat.initialize()
	initialize_player()
	initialize_opponent()
	$ContentAnchor/Battlefield.connect("deploy_zone_input", self, "_on_DeployZone_input")
	$ContentAnchor/Battlefield.connect("zone_of_influence_input", self, "_on_ZoneOfInfluence_input")

func _process(delta):
	check_battle_end()

func initialize_player():
	player.set_color(Global.get_player_color())
	player.increase_speed(25)
	player.update_graphic(playerOneGraphic)
	player.position = Vector2(100, 300)
	player.connect("turn_complete", $ContentAnchor/CardMat, "attempt_draw")
	player.connect("death", self, "_clean_up_player")
	$ContentAnchor/Battlefield.add_player(player)

func initialize_opponent():
	opponent.set_spawn($ContentAnchor/Battlefield.get_spawn())
	opponent.set_enemy_base(player)
	opponent.connect("spawn_monster", $ContentAnchor/Battlefield, "add_monster")
	add_child(opponent)

func check_battle_end():
	if not opponent.has_base():
		get_tree().change_scene("res://Screens/Victory.tscn")
	elif game_over:
		get_tree().change_scene("res://Screens/Defeat.tscn")

func _clean_up_player():
	game_over = true;

func _on_DeployZone_input(event):
	if $ContentAnchor/CardMat.is_utility_card_ready(event):
		_play_utility_card_selected(event.position)
	elif $ContentAnchor/CardMat.is_card_ready(event):
		_play_monster_card_selected(event.position)

func _on_ZoneOfInfluence_input(event):
	if $ContentAnchor/CardMat.is_utility_card_ready(event):
		_play_utility_card_selected(event.position)

func _play_utility_card_selected(event_position):
	var card = $ContentAnchor/CardMat.play_card()
	var action = card.utility_action()
	$ContentAnchor/Battlefield.add_action(action, event_position)

func _play_monster_card_selected(event_position):
	var card = $ContentAnchor/CardMat.play_card()
	card.reset_monster()
	var monster = card.get_monster()
	monster.set_friendly()
	monster.set_color(Global.get_player_color())
	monster.set_target(opponent.get_base())
	monster.set_enemy_base(opponent.get_base())
	$ContentAnchor/Battlefield.monster_from_click(monster, event_position)
