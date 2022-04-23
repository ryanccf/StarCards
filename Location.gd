extends Node2D

var rotation_speed = 0
var rng = RandomNumberGenerator.new()

signal beacon

# Called when the node enters the scene tree for the first time.
func _ready():
	set_sprite();
	rng.randomize()
	#rotation_speed = rng.randf_range(-5.0, 5.0)
	$Sprite.set_scale(Vector2(1.2, 1.2))

func set_sprite():
	var dir = Directory.new()
	var planets = []
	var base_planet_image_dir = 'res://images/planets'
	dir.open(base_planet_image_dir)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if (!file_name.begins_with(".") and !file_name.ends_with(".import")):
			planets.push_back(load(base_planet_image_dir + '/' + file_name))
		file_name = dir.get_next()
	planets.shuffle()
	$Sprite.set_texture(planets.pop_back())

func _process(delta):
	rotation += delta * rotation_speed

func generate_battle():
	get_tree().change_scene("res://Battle.tscn")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("beacon", position.x, position.y)

#This causes a battle when you click nodes lol
#func _on_Area2D_input_event(viewport, event, shape_idx):
#	if (event is InputEventMouseButton && event.pressed):
#		generate_battle()

func dehydrate():
	return {
		"position" : position,
		"solar_system" : $SolarSystem.dehydrate()
	}

func rehydrate(configuration):
	position = configuration.position
	$SolarSystem.rehydrate(configuration.solar_system)
#	$SolarSystem.initialize()

func initialize():
	$SolarSystem.initialize()
