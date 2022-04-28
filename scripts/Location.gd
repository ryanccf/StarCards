extends Node2D

var ActivityMenu = preload("res://Utilities/ActivityMenu.tscn")
var rotation_speed = 0
var rng = RandomNumberGenerator.new()
var menu

signal beacon

# Called when the node enters the scene tree for the first time.
func _ready():
	menu = ActivityMenu.instance()
	add_child(menu)
	rng.randomize()

func _process(delta):
	rotation += delta * rotation_speed

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("beacon", position.x, position.y, self)
		#$ActivityMenu.popup()
		#$ActivityMenu.rect_position = position

func activate_menu():
	if not $ActivityMenu.visible:
		$ActivityMenu.popup()
		$ActivityMenu.rect_position = position
#	else:
#		$ActivityMenu.click_button()

func add_activity(name, event):
	$ActivityMenu.add_activity(name, event)

func dehydrate():
	return {
		"position" : position,
		"solar_system" : $SolarSystem.dehydrate(),
		"activities" : $ActivityMenu.dehydrate()
	}

func rehydrate(configuration):
	position = configuration.position
	$SolarSystem.rehydrate(configuration.solar_system)
	$ActivityMenu.rehydrate(configuration.activities)

func initialize():
	$SolarSystem.initialize()
