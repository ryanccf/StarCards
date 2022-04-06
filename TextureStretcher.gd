extends Control

func _ready():
	_resize_children()

func _process(delta):
	_resize_children()

func _resize_children():
	for child in get_children():
		if "texture" in child:
			var texture_size = child.texture.get_size()
			child.scale = Vector2(rect_size.x / texture_size.x, rect_size.y / texture_size.y)
			child.position = rect_size / 2
