extends Node2D

var cardID = ""
var front_image
var back_image
var flipped = true

func set_id(value):
	self.cardID = value

func get_id():
	return self.cardID

func set_front_image(texture):
	front_image = texture
	update_texture()
	
func set_back_image(texture):
	back_image = texture
	update_texture()

func update_texture():
	if flipped == true:
		$Icon.texture = load(front_image)
	else:
		$Icon.texture = load(back_image)

func _physics_process(delta):
	pass

