extends Node2D

var ActivityMenu = preload("res://Utilities/ActivityMenu.tscn")
var QuestMarker = preload("res://Utilities/QuestMarker.tscn")
var rotation_speed = 0
var rng = RandomNumberGenerator.new()
var menu
var location_name

signal beacon
signal quest(origin_name, destination_name)

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

func add_activity(name, type):
	$ActivityMenu.add_activity(name, type)

func add_quest(destination_name):
	$ActivityMenu.add_quest(destination_name)
	$ActivityMenu.connect("quest", self, "_broadcast_quest")
#	print("added quest to...")
#	print(get_name())

func _broadcast_quest(destination_name):
	print("Broadcasting quest from location")
	print(get_name())
	print(destination_name)
	emit_signal("quest", get_name(), destination_name)

func set_battle_path(battle_path):
	$ActivityMenu.set_battle_path(battle_path)

func set_name(name):
	$Label.text = name

func get_name():
#	print("LOCAITON GANG")
#	print($Label.text)
	return $Label.text

func dehydrate():
	return {
		"name" : $Label.text,
		"position" : position,
		"solar_system" : $SolarSystem.dehydrate(),
		"activities" : $ActivityMenu.dehydrate()
	}

func rehydrate(configuration):
	$Label.text = configuration.name
	position = configuration.position
	$SolarSystem.rehydrate(configuration.solar_system)
	$ActivityMenu.rehydrate(configuration.activities)

func initialize():
	$SolarSystem.initialize()

func add_quest_marker(origin_name):
	var quest_marker = QuestMarker.instance()
	$QuestMarkers.add_child(quest_marker)
	$ActivityMenu.add_quest_destination(origin_name)
