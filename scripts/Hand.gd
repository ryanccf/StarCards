extends "res://scripts/stack.gd"

var selected_card_id

func unselect_cards():
	for card in cards:
		card.unselect()

func has_selected():
	return selected_card_id != null

func handle_selection(card_id):
	unselect_cards()
	set_selected(card_id)
	
func set_selected(card_id):
	selected_card_id = card_id

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
	card.connect("declare_selected", self, "handle_selection")
	card.connect("unselect", self, "unselect")
	cards.append(card)
	card.position = position
	add_child(card)
	
func unselect():
	selected_card_id = null

func pop_selected():
	var card = instance_from_id(selected_card_id)
	card.disconnect("declare_selected", self, "handle_selection")
	card.disconnect("unselect", self, "unselect")
	cards.erase(card)
	card.unselect()
	unselect()
	print(str(selected_card_id))
	print(selected_card_id == null)
	return card
