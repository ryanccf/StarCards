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
	if flipped == true:
		$Area2D/Icon.texture = load(front_image)
	else:
		$Area2D/Icon.texture = load(back_image)

func _physics_process(delta):
	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	#print("Event Fired!")
	if event is InputEventMouseButton and event.pressed:
		print("Clicked!")
		get_tree().set_input_as_handled()
