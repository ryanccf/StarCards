extends Node2D

var screen_height = OS.get_real_window_size().y
var START_POSITION = Vector2(120, screen_height / 2)

var Location = preload("res://Location.tscn")
var GamePiece = preload("res://GamePiece.tscn") 
var player = GamePiece.instance()
var start = Location.instance()
var end = Location.instance()
var first = Location.instance()
var second = Location.instance()
var third = Location.instance()
var locations = []#start, first, second, third, end]

func _ready():
	if Global.get_map() == null:
		generate_level()
		Global.set_map(dehydrate())
	else:
		rehydrate(Global.get_map())
	place_player()

func initialize_locations():
	add_child(start)
	add_child(first)
	add_child(second)
	add_child(third)
	add_child(end)
	start.connect("beacon", self, "_on_beacon")
	first.connect("beacon", self, "_on_beacon")
	second.connect("beacon", self, "_on_beacon")
	third.connect("beacon", self, "_on_beacon")
	end.connect("beacon", self, "_on_beacon")

func place_player():
	add_child(player)
	if Global.get_player_position() == null:
		Global.set_player_position(START_POSITION)
	player.position = Global.get_player_position()
	player.turn_camera_on()
	player.set_color(Global.get_player_color())
	if Global.get_target_position() == null:
		Global.set_target_position(START_POSITION)
	player.set_target_location(Global.get_target_position())

func generate_level():
	for position in generate_location_positions():
		var location = Location.instance()
		location.position = position
		add_location(location)
		location.initialize()

func generate_location_positions():
	return [
		START_POSITION, 
		Vector2(START_POSITION.x + 200, START_POSITION.y + 200), 
		Vector2(START_POSITION.x + 400, START_POSITION.y + 200),
		Vector2(START_POSITION.x + 560, START_POSITION.y + 400),
		Vector2(START_POSITION.x + 660, START_POSITION.y + 600)
	]

func add_location(location):
	add_child(location)
	location.connect("beacon", self, "_on_beacon")
	locations.push_back(location)

func _on_beacon(locX, locY):
	if (player.position.distance_to(Vector2(locX, locY)) <= 4):
		Global.set_player_position(Vector2(locX, locY))
		_exit("res://Battle.tscn")
	else:
		player.look_at(Vector2(locX, locY))
		player.set_target_location(Vector2(locX, locY))
		Global.set_target_position(Vector2(locX, locY))
		Global.store_save_data()

func _process(delta):
	$DeckButtonAnchor.position = player.position - Vector2(300, 0)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		_exit("res://Scenes/DeckEditor.tscn")

func _exit(new_scene_path):
	Global.set_player_position(player.position)
	get_tree().change_scene(new_scene_path)

func dehydrate():
	var configuration = []
	for location in locations:
		configuration.push_back(location.dehydrate())
	return configuration

func rehydrate(configuration):
	for location_configuration in configuration:
		var location = Location.instance()
		add_location(location)
		location.rehydrate(location_configuration)
