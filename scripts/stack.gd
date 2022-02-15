extends Control

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
	card.scale = Vector2(0.5, 0.5)
	cards.append(card)
	refresh_scene(card)

func refresh_scene(card):
	card.position = rect_position
	add_child(card)

func draw_card():
	return cards.pop_front().duplicate()

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
