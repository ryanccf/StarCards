extends Node2D

var minimum_radius = 20
var maximum_radius = 40
var minimum_offset = 0
var maximum_offset = 0
var minimum_rotation_speed = 10
var maximum_rotation_speed = 100
var minimum_color = Color(1, 0.2, 0)
var maximum_color = Color(0, 0.2, 1)
var rng = RandomNumberGenerator.new()
var offset = 0
var should_draw_orbit = false#true
var rotation_speed
var radius
var color

var CelestialBody = load("res://Utilities/CelestialBody.tscn")

func _ready():
	pass

func _process(delta):
	if rotation_speed != null:
		rotation += delta * rotation_speed
		position = position.rotated(delta * rotation_speed)
#	dehydrate()

func initialize():
	rng.randomize()
	#rotation = rng.randf_range(0, 2 * PI)
	rotation_speed = get_rotation_speed()
	_draw()
	position.x += offset
	var rotation_amount = rng.randf_range(0, 2 * PI)
	position = position.rotated(rotation_amount)
	rotation = rotation_amount
	for child in get_children():
		child.initialize()

func _draw():
	var center = Vector2(0, 0)
	var radius = get_radius()
	var angle_from = 0#75
	var angle_to = 360#195
	var color = get_color()
	
	if should_draw_orbit:
		draw_orbit(Vector2(offset * -1, 0), offset, angle_from, angle_to, Color(1, 1, 1))
	
	_draw_circle_arc_poly(center, radius, angle_from, angle_to, color)


func _draw_circle_arc_poly(center, radius, angle_to, angle_from, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)

func draw_orbit(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

func get_radius():
	if radius == null:
		radius = get_random_radius()
	return radius

func set_offset(new_offset):
	offset = new_offset

func get_offset():
	return offset

func set_minimum_radius(radius):
	minimum_radius = radius

func set_maximum_radius(radius):
	maximum_radius = radius

func set_minimum_offset(offset):
	minimum_offset = offset

func set_maximum_offset(offset):
	maximum_offset = offset

func set_minimum_rotation_speed(speed):
	minimum_rotation_speed = speed

func set_maximum_rotation_speed(speed):
	maximum_rotation_speed = speed

func set_minimum_color(color):
	minimum_color = color

func set_maximum_color(color):
	maximum_color = color

func get_random_radius():
	return rng.randf_range(minimum_radius, maximum_radius)

func get_random_rotation_speed():
	return rng.randf_range(minimum_rotation_speed, maximum_rotation_speed)

func get_rotation_speed():
	if rotation_speed == null:
		rotation_speed = get_random_rotation_speed()
	return rotation_speed
	

func get_random_color():
	return Color(rng.randf_range(minimum_color[0], maximum_color[0]), rng.randf_range(minimum_color[1], maximum_color[1]), rng.randf_range(minimum_color[2], maximum_color[2]), rng.randf_range(minimum_color[3], maximum_color[3]))

func get_color():
	if color == null:
		color = get_random_color()
	return color

func dehydrate():
	var serialization = {
		"radius" : get_radius(),
		"offset" : get_offset(),
		"color" : get_color(),
		"rotation_speed" : get_rotation_speed(),
		"children" : []
	}
	for child in get_children():
		serialization.children.push_back(child.dehydrate())
	
	return serialization

func rehydrate(serialization):
	radius = serialization.radius
	offset = serialization.offset
	color = serialization.color
	rotation_speed = serialization.rotation_speed
	for configuration in serialization.children:
		var node = CelestialBody.instance()
		node.rehydrate(configuration)
		add_child(node)
	return self
