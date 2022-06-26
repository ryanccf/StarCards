extends Node2D

var DebugRect = preload("res://Utilities/DebugRect.tscn")

var screen_height = OS.get_real_window_size().y
var START_POSITION = Vector2(120, screen_height / 2)
var rng = RandomNumberGenerator.new()
var name_generator = preload("res://Utilities/NameGenerator.tscn").instance()

var StoryTeller = preload("res://Utilities/StoryTeller.tscn")
var BlackHole = preload("res://Locations/BlackHole.tscn")
var Location = preload("res://Locations/Location.tscn")
var GamePiece = preload("res://Utilities/GamePiece.tscn") 
var player = GamePiece.instance()
var locations = []
var target_location

const QUEST_COUNT = 30

func _ready():
	$DeckButtonAnchor/StoryTeller.connect("story_event", self, "_save_map")
	rng.randomize()
	if Global.get_map() == null:
		generate_level()
		place_black_hole()
		place_player()
		Global.set_map(dehydrate())
		_exit("res://Screens/LevelMap.tscn")
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
		location.connect("quest", self, "_handle_quest")
		location.connect("reward", self, "_handle_reward")
	var unordered_locations = []
	for location in locations:
		unordered_locations.push_back(location)
	locations.shuffle()
	for i in range(QUEST_COUNT):
		var location = locations[i]
		unordered_locations.shuffle()
		var destination = unordered_locations[0]
		while location == destination:
			unordered_locations.shuffle()
			destination = unordered_locations[0]
		location.add_quest(destination.get_name())

func generate_location_positions():
	var positions = []
	var offset 
	var cursor_position = START_POSITION + Vector2.ZERO
	var cursor_rotation = 0
#	var j = 0
	var k = 0
	var SOLAR_SYSTEM_COUNT = 60
	var SYSTEMS_PER_ARM = SOLAR_SYSTEM_COUNT / 6
	var START = 1
	var STEP = 1
	var END = SYSTEMS_PER_ARM * STEP + START

#	for i in range(START, END, STEP):
#		offset = Vector2(Vector2(rng.randf_range(-25, 25), rng.randf_range(-25, 25)))
#		cursor_rotation += 1.03498025
#		#j += 3
#		cursor_position = cursor_position + Vector2((10) * 6, 0).rotated(cursor_rotation)
#		positions.push_back(cursor_position)# + offset)

	var EDGE_DISTANCE = 160
	var Y_OFFSET = -0.44 * EDGE_DISTANCE / cos(PI / 3)
	var X_OFFSET = EDGE_DISTANCE / 2#/ 2
	cursor_position += Vector2(X_OFFSET, Y_OFFSET)
	var cursor_info
	
	for i in range(START, END, STEP):
		offset = Vector2(Vector2(rng.randf_range(-25, 25), rng.randf_range(-25, 25)))
		for j in range(6):
			cursor_rotation += PI / 3
			cursor_position = cursor_position + Vector2(EDGE_DISTANCE * i, 0).rotated(cursor_rotation)
			positions.push_back(cursor_position + offset)
		cursor_position = cursor_position + Vector2(X_OFFSET, Y_OFFSET)
		cursor_rotation = adjust_rotation(START_POSITION, cursor_position, cursor_rotation, 0.03)
		cursor_position = rotate_around(START_POSITION, cursor_position, cursor_rotation, 0.03)#PI / 9)

	Global.set_player_position(positions[-1])
	Global.set_target_position(positions[-1])
	return positions

func rotate_around(center, current_position, current_rotation, angle):
	var current_x = current_position.x - center.x
	var current_y = current_position.y - center.y
	var hypotenuse = sqrt((current_x*current_x) + (current_y*current_y))
	var current_angle = asin(current_y / hypotenuse)
	#var current_angle = atan(current_y / current_y)
	var next_angle = current_angle - angle
	var next_y = hypotenuse * sin(next_angle)
	var next_x = hypotenuse * cos(next_angle)
	var next_position = center + Vector2(next_x, next_y)
	var next_rotation = current_rotation

	return next_position
	
func adjust_rotation(center, current_position, current_rotation, angle):
	var current_x = current_position.x - center.x
	var current_y = current_position.y - center.y
	var hypotenuse = sqrt((current_x*current_x) + (current_y*current_y))
	var current_angle = asin(current_y / hypotenuse)
	var next_angle = current_angle - angle
	var next_y = hypotenuse * sin(next_angle)
	var next_x = hypotenuse * cos(next_angle)
	var next_position = center + Vector2(next_x, next_y)
	
	var p1Angle = atan(current_x / current_y)
	var p2Angle = atan(next_x / next_y)
	var offset = p2Angle - p1Angle
	
	return current_rotation - offset
	

func add_location(location):
	add_child(location)
	location.connect("beacon", self, "_on_beacon")
	locations.push_back(location)

func _start_battle():
	_exit("res://Battles/NormalBattle.tscn")

func _start_boss_battle():
	_exit("res://Battles/BossBattle.tscn")
	
func _activate_location_menu(position):
	if target_location and position.x - target_location.position.x < 1 and  position.y - target_location.position.y < 1:
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

#func _process(delta):
#	$DeckButtonAnchor.position = player.position - Vector2(300, 0)

func _exit(new_scene_path):
	Global.set_player_position(player.position)
	_save_map()
	get_tree().change_scene(new_scene_path)

func dehydrate():
	var configuration = {
		"locations" : [],
		"story_teller" : $DeckButtonAnchor/StoryTeller.dehydrate()
	}
	for location in locations:
		configuration.locations.push_back(location.dehydrate())
	return configuration

func rehydrate(configuration):
	$DeckButtonAnchor/StoryTeller.rehydrate(configuration.story_teller)
	for location_configuration in configuration.locations:
		var location = Location.instance()
		location.initialize()
		location.rehydrate(location_configuration)
		add_location(location)
		location.connect("quest", self, "_handle_quest")
		location.connect("reward", self, "_handle_reward")
		location.connect("save_map", self, "_save_map")

func _on_Button_pressed():
	_exit("res://Screens/DeckEditor.tscn")

func _pause_world():
	get_tree().paused = true
	print(_get_nearest_position_on_screen(player.position, player.position))

func _unpause_world():
	get_tree().paused = false

func _handle_player_arrival(position):
	_pause_world()
	_activate_location_menu(position)

func _handle_quest(origin_name, destination_name):
	var destination = _get_location(destination_name)
	destination.add_quest_marker(origin_name)
	
	var debug_rect = DebugRect.instance()
	add_child(debug_rect)
	debug_rect.position = _get_nearest_position_on_screen(player.position, destination.position)
	
	var debug_rect2 = DebugRect.instance()
	add_child(debug_rect2)
	debug_rect2.position = player.position
	
	print(_get_nearest_position_on_screen(player.position, destination.position))
	_save_map()

func _handle_reward():
	_save_map()

func _get_location(name):
	for location in locations:
		if location.get_name() == name:
			return location

func _save_map():
	Global.set_map(dehydrate())

func _get_nearest_position_on_screen(player_position, target_position):
	var window_area = OS.get_window_safe_area()
	if window_area.has_point(target_position):
		return target_position
	else:
		var point
		var angle_to_target = player_position.angle_to(target_position)
		var angle_to_lower_right_corner = player_position.angle_to(window_area.end)
		var angle_to_lower_left_corner = player_position.angle_to(Vector2(window_area.position.x, window_area.end.y))
		var angle_to_upper_left_corner = player_position.angle_to(window_area.position)
		var angle_to_upper_right_corner = player_position.angle_to(Vector2(window_area.end.x, window_area.position.y))
		if angle_to_target == angle_to_lower_right_corner:
			point = window_area.end
		elif angle_to_target == angle_to_lower_left_corner:
			point = Vector2(window_area.position.x, window_area.position.y)
		elif angle_to_target == angle_to_upper_left_corner:
			point = window_area.position
		elif angle_to_target == angle_to_upper_right_corner:
			point = Vector2(window_area.end.x, window_area.position.y)
		elif angle_to_target < angle_to_lower_right_corner or angle_to_target > angle_to_upper_right_corner:
			#Right side of screen
			point = Vector2(window_area.end.x, tan(angle_to_target) * (window_area.end.x - player_position.x))
		elif angle_to_target < angle_to_lower_left_corner:
			#Bottom of screen
			point = Vector2(tan(angle_to_target) * (window_area.end.y - player_position.y), window_area.end.y)
		elif angle_to_target < angle_to_upper_left_corner:
			#Left side of screen
			point = Vector2(window_area.position.x, tan(angle_to_target) * (player_position.x - window_area.position.x))
		else:
			#Top of screen
			point = Vector2(tan(angle_to_target) * (player_position.y - window_area.position.y), window_area.position.y)
		return point
