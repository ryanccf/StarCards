extends Node2D

const Monster = preload("res://Monster.tscn")

var monster
var cardID = ""
var front_image
var back_image
var flipped = true
var selected = false
var selectable = false
var on_select
var card_scale = Vector2(0.2, 0.2)
var card_large_scale = Vector2(0.3, 0.3)

signal declare_selected(card_id)
signal unselect()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if selectable:
			if !selected:
				emit_signal("declare_selected", get_instance_id())
#				if on_select:
#					on_select.call_func()
				selected = true
			else:
				selected = false
				emit_signal("unselect")

func _ready():
	reset_monster()

func _process(delta):
	if selected:
		scale = card_large_scale
		z_index = 9		
	else:
		scale = card_scale
		z_index = 1

func reset_monster():
	monster = Monster.instance()

func unselect():
	selected = false

func set_id(value):
	self.cardID = value

#func set_on_select(function_reference):
#	on_select = function_reference

func get_id():
	return self.cardID

func set_image(front_texture, back_texture):
	front_image = front_texture
	back_image = back_texture
	update_texture()

func update_texture():
	if flipped:
		$Area2D/Icon.texture = front_image #load(front_image)
		$Area2D/Icon/ColorRect.visible = true
	else:
		$Area2D/Icon.texture = back_image #load(back_image)
		$Area2D/Icon/ColorRect.visible = false

func set_selectable(truthiness):
	selectable = truthiness

func set_selected(truthiness):
	selected = truthiness

func flip():
	flipped = !flipped
	update_texture()
	$Header/Title.visible = flipped
	$Area2D/Icon/Graphic.visible = flipped

func set_monster(new_monster):
	monster = new_monster

func get_monster():
	return monster


