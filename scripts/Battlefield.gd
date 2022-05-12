extends Control
var Laser = preload("res://Actions/Laser.tscn")
var DirectAttack = preload("res://Actions/DirectAttack.tscn")
var playerOneGraphic = load("res://images/ship_H.png")
var PlayerCharacter = preload("res://Battles/Utilities/PlayerCharacter.tscn")
var opponent = preload("res://Opponents/Opponent.tscn").instance()
var player = PlayerCharacter.instance()
var game_over = false
var monsters = []
var victory_path = "res://Screens/Victory.tscn"
signal deploy_zone_input(event)
signal zone_of_influence_input(event)
signal turn_complete

func set_opponent(new_opponent):
	opponent = new_opponent

func _process(delta):
	check_battle_end()

func set_victory_path(new_victory_path):
	victory_path = new_victory_path

func check_battle_end():
	if not opponent.has_base():
		get_tree().change_scene(victory_path)
	elif game_over:
		get_tree().change_scene("res://Screens/Defeat.tscn")

func _ready():
	initialize_player()
	initialize_opponent()

func initialize_player():
	player.set_color(Global.get_player_color())
	player.increase_speed(25)
	player.update_graphic(playerOneGraphic)
	player.position = Vector2(100, 300)
	$Field.add_child(player)
	player.connect("turn_complete", self, "_broadcast_turn_complete")
	player.connect("death", self, "_on_player_death")

func initialize_opponent():
	opponent.set_spawn($Field/SpawnPoint.position)
	opponent.set_enemy_base(player)
	opponent.connect("spawn_monster", self, "add_monster")
	add_child(opponent)

func _broadcast_turn_complete():
	emit_signal("turn_complete")

func _on_player_death():
	game_over = true;

func add_action(action, event_position):
	$Field.add_child(action)
	action.set_position(event_position - $ZoneOfInfluence.global_position)

func monster_from_click(monster, event_position):
	monster.set_color(Global.get_player_color())
	monster.set_target(opponent.get_base())
	monster.set_enemy_base(opponent.get_base())
	add_monster(monster, event_position - $DeployZone.global_position)

func _on_DeployZone_input_event(viewport, event, shape_idx):
	emit_signal("deploy_zone_input", event)

func _on_ZoneOfInfluence_input_event(viewport, event, shape_idx):
	emit_signal("zone_of_influence_input", event)

func add_monster(monster, position):
	monster.set_middle(300)#$Field/Field.shape.radius / 2)
	monster.set_position(position)
	monster.set_bounds($Field/Bounds)
	monster.connect("spawn_laser", self, "_handle_laser_spawn")
	monster.connect("boom", self, "_handle_boom")
	$Field.add_child(monster)
	
func _handle_laser_spawn(laser_position, laser_rotation, laser_target, is_friendly, damage):
	var laser = Laser.instance()
	laser.position = laser_position
	laser.rotation = laser_rotation
	laser.set_target(laser_target)
	laser.set_friendly(is_friendly)
	laser.set_damage(damage)
	$Field.add_child(laser)

func _handle_boom(position):
	for _i in 3:
		var direct_attack = DirectAttack.instance()
		direct_attack.position = position
		$Field.add_child(direct_attack)
