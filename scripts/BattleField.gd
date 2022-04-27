extends Control
signal deploy_zone_input(event)
signal zone_of_influence_input(event)

func add_player(player):
	$Field.add_child(player)

func get_spawn():
	return $Field/SpawnPoint

func add_monster(monster, position):
	$Field.add_monster(monster, position)

func add_action(action, event_position):
	$Field.add_child(action)
	action.set_position(event_position - $ZoneOfInfluence.global_position)

func monster_from_click(monster, event_position):
	$Field.add_monster(monster, event_position - $DeployZone.global_position)

func _on_DeployZone_input_event(viewport, event, shape_idx):
	emit_signal("deploy_zone_input", event)

func _on_ZoneOfInfluence_input_event(viewport, event, shape_idx):
	emit_signal("zone_of_influence_input", event)
