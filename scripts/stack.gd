extends Node2D

var cards = []
var x_offset = 1
var y_offset = 0
var face_down = true

func _draw():
	pass
	#draw_circle(Vector2.ZERO, 5, Color.blanchedalmond)

func set_x_offset(x):
	x_offset = x

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.webmaroon
	
func deselect():
	modulate = Color.white

func add_card(card):
	card.scale.x = 0.2#0.01
	card.scale.y = 0.2#0.014
	cards.push_front(card)
	refresh_scene(card)

func refresh_scene(card):
	card.position.x = position.x + (x_offset * cards.size())
	card.position.y = position.y
	add_child(card)

func draw_card():
	return cards.pop_front()

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
