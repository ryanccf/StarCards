extends Node2D

var rotation_speed = 0
var rng = RandomNumberGenerator.new()


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	rotation_speed = rng.randf_range(-5.0, 5.0)

func _process(delta):
	rotation += delta * rotation_speed
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
