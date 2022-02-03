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
	player.position = START_POSITION
	player.turn_camera_on()
	start.position = START_POSITION
	first.position = Vector2(start.position.x + 200, start.position.y + 200)
	second.position = Vector2(first.position.x + 200, first.position.y)
	third.position = Vector2(second.position.x + 160, second.position.y + 200)
	end.position = Vector2(third.position.x + 100, third.position.y + 200)
	start.set_locID(1)
	first.set_locID(2)
	second.set_locID(3)
	third.set_locID(4)
	end.set_locID(5)
	start.connect("beacon", self, "_on_beacon")
	first.connect("beacon", self, "_on_beacon")
	second.connect("beacon", self, "_on_beacon")
	third.connect("beacon", self, "_on_beacon")
	end.connect("beacon", self, "_on_beacon")

func _on_beacon(locID, locX, locY):
	if (player.position.x == locX and player.position.y == locY):
		get_tree().change_scene("res://Battle.tscn")
	elif (locID == (player.get_location() - 1) or locID == (player.get_location() + 1)):
		player.set_location(locID)
		player.look_at(Vector2(locX, locY))
		player.move_to(locX, locY)
