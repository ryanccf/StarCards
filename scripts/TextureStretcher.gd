extends Control

func _ready():
	_resize_children()

func _process(delta):
	_resize_children()

func _resize_children():
	for child in get_children():
		if "texture" in child:
			var texture_size = child.texture.get_size()
			var modifier = rect_size.x if rect_size.x > rect_size.y else rect_size.y
			child.scale = Vector2(modifier / texture_size.x, modifier / texture_size.y)
			child.position = rect_size / 2
