extends Node2D

func set_color(color):
	$ColorRect.color = color
	$ReferenceRect.border_color = color

func mimic(rectangle):
	position = Vector2.ZERO
	$ColorRect.rect_position = rectangle.position
	$ColorRect.rect_size = rectangle.size
	$ReferenceRect.rect_position = rectangle.position
	$ReferenceRect.rect_size = rectangle.size

func toggle_border():
	$ColorRect.visible = not $ColorRect.visible
	$ReferenceRect.visible = not $ReferenceRect.visible
