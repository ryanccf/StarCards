extends Node2D
var speed = 110

func _process(delta):
	position += speed * delta * Vector2(cos(rotation), sin(rotation))
