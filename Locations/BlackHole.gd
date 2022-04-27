extends "res://Locations/Location.gd"
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
		emit_signal("boss_beacon", position.x, position.y)
