extends Node2D

var stack_scale = Vector2(0.2, 0.2)
var cards = []
var offset = Vector2(1, 0)
var face_down = true
var selectable = false

func _draw():
	draw_circle(Vector2.ZERO, 25, Color.blanchedalmond)

func _process(_delta):
	refresh_card_positions()

func unselect_cards():
	for card in cards:
		card.unselect()

func set_offset(new_offset):
	offset = new_offset

func all_cards():
	return cards

func last_card_position():
	return cards.back().position

func set_selectable(truthiness):
	selectable = truthiness

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	modulate = Color.webmaroon
	
func deselect():
	modulate = Color.white

func add_card(card):
	if selectable:
		card.set_selectable(true) 
	card.scale = stack_scale
	card.position += (offset * cards.size())
	card.set_on_select(funcref(self, "unselect_cards"))
	cards.append(card)
	card.position = position
	add_child(card)

func refresh_card_positions():
	var counter = 0
	for card in cards:
		counter += 1
		card.position = position + (offset * counter)

func draw_card():
	if cards.size() > 0:
		var card = cards.pop_back()
		remove_child(card)
		return card
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
