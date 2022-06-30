extends Node2D

func set_color(color):
	$ColorRect.color = color

func mimic(rectangle):
	position = Vector2.ZERO
	$ColorRect.position = rectangle.position
	$ColorRect.end = rectangle.end
