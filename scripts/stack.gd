extends Node2D

var cards = []
var offset_value = 20;

func _draw():
	draw_circle(Vector2.ZERO, 75, Color.blanchedalmond)
	
func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.webmaroon
	
func deselect():
	modulate = Color.white

func add_card(card):
	card.scale.x = 0.01
	card.scale.y = 0.014
	card.position.x += offset_value
	card.position.y += offset_value
	offset_value += 0.02
	cards.push_front(card)
	
func draw_card():
	return cards.pop_front()

func card_count():
	return cards.size()

func shuffle():
	cards.shuffle();

func offset_cards():
	for card in cards:
		emit_signal("assign_card_postion", card_count() + offset_value, card.get_id())

func show_cards():
	if(cards.size() == 0):
		print(0)
	else:
		for card in cards:
			print(card.get_id())
