extends Node2D

var current_location = 1
var speed = 100
var velocity = Vector2()
var target_point = Vector2()
var moving = false

signal player_arrival
signal player_departure

func set_color(new_color):
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
	if Input.is_action_just_released("mouse_wheel_up"):
		zoom_out()
	elif Input.is_action_just_released("mouse_wheel_down"):
		zoom_in()
	if target_point.distance_to(position) > 1:
		if moving == false:
			emit_signal("player_departure")
		move_to(target_point, delta)
		moving = true
	elif moving == true:
		emit_signal("player_arrival", position)
		moving = false

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

func zoom_out():
	$Camera2D.zoom -= Vector2(0.1, 0.1)

func zoom_in():
	$Camera2D.zoom += Vector2(0.1, 0.1)

func get_zoom():
	return $Camera2D.zoom

func _unhandled_input(event):
	if "button_index" in event and event.button_index == BUTTON_LEFT and event.pressed:
		var target = get_global_mouse_position()
		set_target_location(target)
		Global.set_target_position(target)
