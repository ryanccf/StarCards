extends Node2D

var current_location = 1
var speed = 100
var velocity = Vector2()
var target_point = Vector2()

func set_color(new_color):
	print(new_color)
	print("something distinct")
	$Sprite.modulate = new_color

func get_location():
	return current_location

func set_location(new_location):
	current_location = new_location

func set_target_location(new_location):
	target_point = new_location

func _ready():
	pass

func _process(delta):
	if target_point.distance_to(position) > 1: 
		move_to(target_point, delta)

func move_to(target_pos,delta):
	var mass = 5
	var ArriveDistance = 1
	var target_velocity = (target_pos - position).normalized() * speed
	var steering = target_velocity - velocity
	velocity += steering/mass
	position += velocity*delta
	rotation = velocity.angle() + deg2rad(90)
	Global.set_player_position(position)
	return position.distance_to(target_pos) < ArriveDistance

func turn_camera_on():
	$Camera2D.current = true
