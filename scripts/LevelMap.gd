extends Node2D

var screen_height = OS.get_real_window_size().y
var START_POSITION = Vector2(120, screen_height / 2)
var rng = RandomNumberGenerator.new()
var name_generator = preload("res://Utilities/NameGenerator.tscn").instance()

var BlackHole = preload("res://Locations/BlackHole.tscn")
var Location = preload("res://Locations/Location.tscn")
var GamePiece = preload("res://Utilities/GamePiece.tscn") 
var player = GamePiece.instance()
var locations = []
var target_location

func _ready():
	rng.randomize()
	if Global.get_map() == null:
		generate_level()
		Global.set_map(dehydrate())
	else:
		rehydrate(Global.get_map())
	place_black_hole()
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
	get_tree().paused = true
	player.set_target_location(Global.get_target_position())
	player.connect("player_departure", self, "_unpause_world")
	player.connect("player_arrival", self, "_handle_player_arrival")

func place_black_hole():
	var black_hole = BlackHole.instance()
	add_child(black_hole)
	black_hole.connect("boss_beacon", self, "_on_beacon")
	black_hole.initialize()
	black_hole.add_activity("Boss Battle", "battle")
	black_hole.position = START_POSITION
	black_hole.set_battle_path("res://Battles/BossBattle.tscn")
	black_hole.set_name("Warp Gate")
	locations.push_back(black_hole)	
	
func generate_level():
	for position in generate_location_positions():
		var location = Location.instance()
		add_location(location)
		location.initialize()
		location.initialize_solar_system()
		location.position = position
		location.set_name(name_generator.get_name())
		location.add_activity("Battle", "battle")
	var unordered_locations = []
	for location in locations:
		unordered_locations.push_back(location)
	for location in locations:
		unordered_locations.shuffle()
		location.add_quest(unordered_locations[0].get_name())
		location.connect("quest", self, "_handle_quest")
		location.connect("reward", self, "_handle_quest")

func generate_location_positions():
	var positions = []
	var offset 
	var modifier = Vector2(rng.randf_range(150, 200), rng.randf_range(150, 200))
	
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

func _start_battle():
	_exit("res://Battles/Battle.tscn")

func _start_boss_battle():
	_exit("res://Battles/BossBattle.tscn")
	
func _activate_location_menu(position):
	if target_location and position - target_location.position < Vector2(1, 1):
		target_location.activate_menu()

func _on_beacon(locX, locY, location):
	target_location = location
	if (player.position.distance_to(Vector2(locX, locY)) <= 4):
		Global.set_player_position(Vector2(locX, locY))
	else:
		player.look_at(Vector2(locX, locY))
		player.set_target_location(Vector2(locX, locY))
		Global.set_target_position(Vector2(locX, locY))
		Global.store_save_data()

func _process(delta):
	$DeckButtonAnchor.position = player.position - Vector2(300, 0)

func _exit(new_scene_path):
	Global.set_player_position(player.position)
	_save_map()
	get_tree().change_scene(new_scene_path)

func dehydrate():
	var configuration = []
	for location in locations:
		configuration.push_back(location.dehydrate())
	return configuration

func rehydrate(configuration):
	for location_configuration in configuration:
		var location = Location.instance()
		location.initialize()
		location.rehydrate(location_configuration)
		add_location(location)
		location.connect("quest", self, "_handle_quest")
		location.connect("reward", self, "_handle_reward")

func _on_Button_pressed():
	_exit("res://Screens/DeckEditor.tscn")

func _pause_world():
	get_tree().paused = true

func _unpause_world():
	get_tree().paused = false

func _handle_player_arrival(position):
	_pause_world()
	_activate_location_menu(position)

func _handle_quest(origin_name, destination_name):
	var destination = _get_location(destination_name)
	destination.add_quest_marker(origin_name)
	_save_map()

func _handle_reward():
	_save_map()

func _get_location(name):
	for location in locations:
		if location.get_name() == name:
			return location

func _save_map():
	Global.set_map(dehydrate())
