extends Control

var stack_scale = Vector2(0.2, 0.2)
var cards = []
var offset = Vector2(1, 1)
var face_down = true

func _draw():
	pass
	#draw_circle(Vector2.ZERO, 5, Color.blanchedalmond)

func set_x_offset(x_offset):
	offset = Vector2(x_offset, offset.y)

func last_card_position():
	return cards.back().position

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.webmaroon
	
func deselect():
	modulate = Color.white

func add_card(card):
	card.scale = stack_scale
	cards.append(card)
	refresh_scene(card)

func refresh_scene(card):
	card.position = rect_position
	add_child(card)

func draw_card():
	if cards.size() > 0:
		return cards.pop_back().duplicate()
	else:
		return null

func card_count():
	return cards.size()

func shuffle():
	cards.shuffle()

func show_cards():
	if(cards.size() == 0):
		print(0)
	else:
		for card in cards:
			print(card.get_id())
