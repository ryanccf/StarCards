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

func _ready():
	generate_level()

func generate_level():
	add_child(start)
	add_child(first)
	add_child(second)
	add_child(third)
	add_child(end)
	add_child(player)
	#Global.set_player_name("Hero Protagonist")
	if Global.get_player_position() == null:
		Global.set_player_position(START_POSITION)
	player.position = Global.get_player_position()
	#player.position = START_POSITION
	player.turn_camera_on()
	player.set_color(Global.get_player_color())

	start.position = START_POSITION
	first.position = Vector2(start.position.x + 200, start.position.y + 200)
	second.position = Vector2(first.position.x + 200, first.position.y)
	third.position = Vector2(second.position.x + 160, second.position.y + 200)
	end.position = Vector2(third.position.x + 100, third.position.y + 200)
	start.connect("beacon", self, "_on_beacon")
	first.connect("beacon", self, "_on_beacon")
	second.connect("beacon", self, "_on_beacon")
	third.connect("beacon", self, "_on_beacon")
	end.connect("beacon", self, "_on_beacon")
	if Global.get_target_position() == null:
		Global.set_target_position(start.position)
	player.set_target_location(Global.get_target_position())

func _on_beacon(locX, locY):
	if (player.position.distance_to(Vector2(locX, locY)) <= 4):
		_exit("res://Battle.tscn")
	else:
		player.look_at(Vector2(locX, locY))
		player.set_target_location(Vector2(locX, locY))
		Global.set_target_position(Vector2(locX, locY))

func _process(delta):
	$DeckButtonAnchor.position = player.position - Vector2(300, 0)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		_exit("res://Scenes/DeckEditor.tscn")

func _exit(new_scene_path):
	Global.set_player_position(player.position)
	get_tree().change_scene(new_scene_path)
