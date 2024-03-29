extends "res://scripts/Location.gd"
signal boss_beacon(x, y)

func _ready():
	$Aura.rehydrate({
		"radius" : 40,
		"offset" : 0,
		"color" : Color(1, 1, 1),
		"rotation_speed" : 0,
		"children" : [{
			"radius" : 38,
			"offset" : 0,
			"color" : Color(0, 0, 0),
			"rotation_speed" : 0,
			"children" : []
		}]
	})	

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("boss_beacon", position.x, position.y, self)

func dehydrate():
	return {
		"position" : position,
		"solar_system" : $Aura.dehydrate(),
		"activities" : $ActivityMenu.dehydrate(),
		"name" : get_name()
	}

func rehydrate(configuration, get_nearest_position):
	position = configuration.position
	$Aura.rehydrate(configuration.solar_system)
	$ActivityMenu.rehydrate(configuration.activities, get_nearest_position)
	
func initialize():
	menu = ActivityMenu.instance()
	add_child(menu)
#	rng.randomize()
