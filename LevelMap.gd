extends Node2D

var screen_height = OS.get_real_window_size().y
var START_POSITION = Vector2(120, screen_height / 2)
var rng = RandomNumberGenerator.new()

var Location = preload("res://Location.tscn")
var GamePiece = preload("res://GamePiece.tscn") 
var player = GamePiece.instance()
var locations = []

func _ready():
	rng.randomize()
	if Global.get_map() == null:
		generate_level()
		Global.set_map(dehydrate())
	else:
		rehydrate(Global.get_map())
	place_player()

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
	var positions = []
	var offset 
	var modifier = Vector2(rng.randf_range(150, 200), rng.randf_range(150, 200))
	
	positions.push_back(START_POSITION)
	
	for i in range(10):
		offset = Vector2(Vector2(rng.randf_range(-25, 25), rng.randf_range(-25, 25)))
		var t = float(i) / 20.0 * PI
		var dx = (1 + 5 * t) * cos(t)
		var dy = (1 + 5 * t) * sin(t)
		positions.push_back(START_POSITION + (Vector2(dx, dy) * modifier) + offset)
		dx *= -1
		dy *= -1
		offset = Vector2(Vector2(rng.randf_range(-25, 25), rng.randf_range(-25, 25)))
		positions.push_back(START_POSITION + (Vector2(dx, dy) * modifier) + offset)
	
	Global.set_player_position(positions[-1])
	Global.set_target_position(positions[-1])
	
	return positions

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
