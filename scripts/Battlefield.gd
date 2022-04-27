extends Control
var Laser = preload("res://Actions/Laser.tscn")
var DirectAttack = preload("res://Actions/DirectAttack.tscn")
var monsters = []
signal deploy_zone_input(event)
signal zone_of_influence_input(event)

func add_player(player):
	$Field.add_child(player)

func get_spawn():
	return $Field/SpawnPoint

func add_action(action, event_position):
	$Field.add_child(action)
	action.set_position(event_position - $ZoneOfInfluence.global_position)

func monster_from_click(monster, event_position):
	add_monster(monster, event_position - $DeployZone.global_position)

func _on_DeployZone_input_event(viewport, event, shape_idx):
	emit_signal("deploy_zone_input", event)

func _on_ZoneOfInfluence_input_event(viewport, event, shape_idx):
	emit_signal("zone_of_influence_input", event)

func add_monster(monster, position):
	$Field.add_child(monster)
	monster.set_position(position)
	monster.set_bounds($Field/Bounds)
	monster.connect("spawn_laser", self, "_handle_laser_spawn")
	monster.connect("boom", self, "_handle_boom")
	
func _handle_laser_spawn(laser_position, laser_rotation, laser_target, is_friendly):
	var laser = Laser.instance()
	laser.position = laser_position
	laser.rotation = laser_rotation
	laser.set_target(laser_target)
	laser.set_friendly(is_friendly)
	laser.connect("target_reached", self, "_clean_up_laser")
	$Field.add_child(laser)

func _handle_boom(position):
	for _i in 3:
		var direct_attack = DirectAttack.instance()
		direct_attack.position = position
		$Field.add_child(direct_attack)

func _clean_up_laser(laser):
	pass
