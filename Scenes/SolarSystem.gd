extends Node2D

var minimum_corona_radius = 35
var maximum_corona_radius = 40
var minimum_corona_color = Color(1, 0.2, 0)
var maximum_corona_color = Color(0, 0.2, 1)

var minimum_star_radius = 20
var maximum_star_radius = 35
var minimum_star_rotation_speed = 0
var maximum_star_rotation_speed = 0
var minimum_star_color = Color(1, 0.2, 0)
var maximum_star_color = Color(0, 0.2, 1)
var minimum_star_satellites = 1
var maximum_star_satellites = 3

var minimum_planet_radius = 5
var maximum_planet_radius = 10
var minimum_planet_rotation_speed = 0.1
var maximum_planet_rotation_speed = 2
var minimum_planet_distance = 10
var maximum_planet_distance = 20
var minimum_planet_color = Color(1, 1, 1)
var maximum_planet_color = Color(0.2, 0.2, 0.2)
var minimum_planet_satellites = 0
var maximum_planet_satellites = 2

var minimum_moon_radius = 1
var maximum_moon_radius = 5
var minimum_moon_rotation_speed = 0.1
var maximum_moon_rotation_speed = 2
var minimum_moon_distance = 3
var maximum_moon_distance = 7
var minimum_moon_color = Color(1, 1, 1)
var maximum_moon_color = Color(0.2, 0.2, 0.2)

const CelestialBody = preload("res://Scenes/CelestialBody.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	var star = CelestialBody.instance()
	rng.randomize()
	var corona = CelestialBody.instance()
	corona.set_minimum_radius(minimum_corona_radius)
	corona.set_maximum_radius(maximum_corona_radius)
	corona.set_minimum_color(minimum_corona_color)
	corona.set_maximum_color(maximum_corona_color)
	corona.set_minimum_rotation_speed(0)
	corona.set_maximum_rotation_speed(0)
	var star_satellite_count = rng.randi_range(minimum_star_satellites, maximum_star_satellites)
	star.set_minimum_radius(minimum_star_radius)
	star.set_maximum_radius(maximum_star_radius)
	star.set_minimum_rotation_speed(minimum_star_rotation_speed)
	star.set_maximum_rotation_speed(maximum_star_rotation_speed)
	star.set_minimum_color(minimum_star_color)
	star.set_maximum_color(maximum_star_color)
	add_child(corona)
	corona.add_child(star)
	var last_planet_offset = corona.get_radius()
	var last_moon_offset = 0
	var last_moon_radius = 0
	for i in range(star_satellite_count):
		var planet = CelestialBody.instance()
		var planet_satellite_count = rng.randi_range(minimum_planet_satellites, maximum_planet_satellites)
		planet.set_minimum_radius(minimum_planet_radius)
		planet.set_maximum_radius(maximum_planet_radius)
		planet.set_minimum_rotation_speed(minimum_planet_rotation_speed)
		planet.set_maximum_rotation_speed(maximum_planet_rotation_speed)
		planet.set_minimum_color(minimum_planet_color)
		planet.set_maximum_color(maximum_planet_color)
		last_planet_offset += planet.get_radius() +  rng.randf_range(minimum_planet_distance, maximum_planet_distance)
		last_planet_offset += last_moon_offset + last_moon_radius
		planet.set_offset(last_planet_offset)
		star.add_child(planet)
		last_moon_offset = planet.get_radius()
		for j in range(planet_satellite_count):
			var moon = CelestialBody.instance()
			moon.set_minimum_radius(minimum_moon_radius)
			moon.set_maximum_radius(maximum_moon_radius)
			moon.set_minimum_rotation_speed(minimum_moon_rotation_speed)
			moon.set_maximum_rotation_speed(maximum_moon_rotation_speed)
			moon.set_minimum_color(minimum_moon_color)
			moon.set_maximum_color(maximum_moon_color)
			last_moon_radius = moon.get_radius()
			last_moon_offset += last_moon_radius + rng.randf_range(minimum_moon_distance, maximum_moon_distance)
			moon.set_offset(last_moon_offset)
			last_moon_offset += last_moon_radius
			planet.add_child(moon)
		planet.set_offset(last_planet_offset + last_moon_offset + last_moon_radius)
		last_planet_offset += planet.get_radius()
