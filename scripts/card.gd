extends Node2D

var cardID = ""
var front_image
var back_image
var flipped = true

func set_id(value):
	self.cardID = value

func get_id():
	return self.cardID

func set_image(front_texture, back_texture):
	front_image = front_texture
	back_image = back_texture
	update_texture()

func update_texture():
	if flipped:
		$Area2D/Icon.texture = front_image #load(front_image)
	else:
		$Area2D/Icon.texture = back_image #load(back_image)

func _physics_process(delta):
	pass

func flip():
	flipped = !flipped
	update_texture()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print("Clicked!")
