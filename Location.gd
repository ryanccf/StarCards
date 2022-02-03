extends Node2D

var rotation_speed = 0
var rng = RandomNumberGenerator.new()
var locID = 0

signal beacon

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	rotation_speed = rng.randf_range(-5.0, 5.0)

func set_locID(newID):
	locID = newID

func get_locID():
	return locID

func _process(delta):
	rotation += delta * rotation_speed

func generate_battle():
	get_tree().change_scene("res://Battle.tscn")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed):
		emit_signal("beacon", locID, position.x, position.y)

#This causes a battle when you click nodes lol
#func _on_Area2D_input_event(viewport, event, shape_idx):
#	if (event is InputEventMouseButton && event.pressed):
#		generate_battle()
