extends Node2D

var ActivityMenu = preload("res://Utilities/ActivityMenu.tscn")
var QuestMarker = preload("res://Utilities/QuestMarker.tscn")
var rotation_speed = 0
var rng = RandomNumberGenerator.new()
var menu
var location_name

signal beacon
signal quest(origin_name, destination_name)
signal reward


func _process(delta):
	rotation += delta * rotation_speed

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("beacon", position.x, position.y, self)
		#menu.popup()
		#menu.rect_position = position

func activate_menu():
	if not menu.visible:
		menu.popup()
		menu.rect_position = position

func add_activity(name, type):
	menu.add_activity(name, type)

func add_quest(destination_name):
	menu.add_quest(destination_name)

func _broadcast_quest(destination_name):
	emit_signal("quest", get_name(), destination_name)

func _broadcast_reward():
	emit_signal("reward")

func set_battle_path(battle_path):
	menu.set_battle_path(battle_path)

func set_name(name):
	$Label.text = name
	menu.set_name(name)

func get_name():
	return $Label.text

func dehydrate():
	return {
		"name" : get_name(),
		"position" : position,
		"solar_system" : $SolarSystem.dehydrate(),
		"activities" : menu.dehydrate()
	}

func rehydrate(configuration):
	$Label.text = configuration.name
	position = configuration.position
	$SolarSystem.rehydrate(configuration.solar_system)
	menu.rehydrate(configuration.activities)
	

func initialize():
	menu = ActivityMenu.instance()
	add_child(menu)
	rng.randomize()
	menu.connect("quest", self, "_broadcast_quest")
	menu.connect("reward", self, "_broadcast_reward")
	menu.connect("rehydrate_reward", self, "rehydrate_quest_marker")

func initialize_solar_system():
	$SolarSystem.initialize()

func add_quest_marker(origin_name):
	var quest_marker = QuestMarker.instance()
	$QuestMarkers.add_child(quest_marker)
	menu.add_quest_destination(origin_name)

func rehydrate_quest_marker(origin_name):
	var quest_marker = QuestMarker.instance()
	$QuestMarkers.add_child(quest_marker)
