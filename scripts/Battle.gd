extends Control

func _ready():
	randomize()
	$ContentAnchor/CardMat.initialize()
	$ContentAnchor/Battlefield.connect("deploy_zone_input", self, "_on_DeployZone_input")
	$ContentAnchor/Battlefield.connect("zone_of_influence_input", self, "_on_ZoneOfInfluence_input")
	$ContentAnchor/Battlefield.connect("turn_complete", $ContentAnchor/CardMat, "attempt_draw")

func _on_DeployZone_input(event):
	if $ContentAnchor/CardMat.is_utility_card_ready(event):
		_play_utility_card_selected(event.position)
	elif $ContentAnchor/CardMat.is_card_ready(event):
		_play_monster_card_selected(event.position)

func _on_ZoneOfInfluence_input(event):
	if $ContentAnchor/CardMat.is_utility_card_ready(event):
		_play_utility_card_selected(event.position)

func _play_utility_card_selected(event_position):
	$ContentAnchor/Battlefield.add_action($ContentAnchor/CardMat.play_action_card(), event_position)

func _play_monster_card_selected(event_position):
	$ContentAnchor/Battlefield.monster_from_click($ContentAnchor/CardMat.play_monster_card(), event_position)
