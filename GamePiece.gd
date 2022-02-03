extends Node2D

var current_location = 1
var speed = 100

func get_location():
	return current_location

func set_location(new_location):
	current_location = new_location

func _ready():
	pass # Replace with function body.

func move_to(new_x, new_y):
	position.x = new_x
	position.y = new_y

func turn_camera_on():
	$Camera2D.current = true
