extends Node2D

var cardID = ""
var front_image
var back_image
var flipped = true
var selected = false
var selectable = false
var on_select
var card_scale = Vector2(0.2, 0.2)
var card_large_scale = Vector2(0.3, 0.3)

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if selectable:
			if !selected:
				if on_select:
					on_select.call_func()
				selected = true
			else:
				selected = false

func _process(delta):
	if selected:
		scale = card_large_scale
		z_index = 9		
	else:
		scale = card_scale
		z_index = 1

func unselect():
	selected = false

func set_id(value):
	self.cardID = value

func set_on_select(function_reference):
	on_select = function_reference

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

func set_selectable(truthiness):
	selectable = truthiness

func set_selected(truthiness):
	selected = truthiness

func flip():
	flipped = !flipped
	update_texture()
