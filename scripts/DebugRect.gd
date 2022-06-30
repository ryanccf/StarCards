extends Node2D

func set_color(color):
	$ColorRect.color = color

func mimic(rectangle):
	position = Vector2.ZERO
	#scale = Vector2(1, 1)
	#$ColorRect.scale = Vector2(1, 1)
	$ColorRect.rect_position = rectangle.position
	$ColorRect.rect_size = rectangle.size
