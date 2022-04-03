extends Control

var _texture_size

func _ready():
	_texture_size = $Galaxy.texture.get_size()
	_resize_galaxy()

func _process(delta):
	_resize_galaxy()

func _resize_galaxy():
	$Galaxy.scale = Vector2(rect_size.x / _texture_size.x, rect_size.y / _texture_size.y)
	$Galaxy.position = rect_size / 2
