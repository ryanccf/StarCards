extends Node2D

var rotation_speed = 0
var rng = RandomNumberGenerator.new()

signal beacon

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

func _process(delta):
	rotation += delta * rotation_speed

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("beacon", position.x, position.y)

func dehydrate():
	return {
		"position" : position,
		"solar_system" : $SolarSystem.dehydrate()
	}

func rehydrate(configuration):
	position = configuration.position
	$SolarSystem.rehydrate(configuration.solar_system)

func initialize():
	$SolarSystem.initialize()
