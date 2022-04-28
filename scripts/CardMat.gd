extends Control

var CardBack =  load("res://images/card_back.png")

func initialize():
	$Hand.set_offset(Vector2(105, 0))
	$Hand.set_selectable(true)
	$Deck.set_offset(Vector2(0, 0))

	var deck = Global.get_decks()[0].get_cards()
	var card
	for card_name in deck:
		card = Global.get_card(card_name)
		card.set_id(card_name)
		var my_filename = "res://images/card_front.png"
		var card_texture = load(my_filename)
		card.set_image(card_texture, CardBack)
		card.flip()
		$Deck.add_card(card)
	$Deck.shuffle()

func reshuffle():
	for _i in range($Discard.card_count()):
		var discarded_card = $Discard.draw_card()
		discarded_card.flip()
		$Deck.add_card(discarded_card)
	$Deck.shuffle()

func play_card():
	var card = $Hand.pop_selected()
	$Discard.add_card(card)
	return card

func play_action_card():
	return play_card().utility_action()

func play_monster_card():
	var card = play_card()
	card.reset_monster()
	var monster = card.get_monster()
	monster.set_friendly()
	return monster

func is_utility_card_ready(event):
	return is_card_ready(event) and $Hand.get_selected().has_method("utility_action")

func is_card_ready(event):
	return event is InputEventMouseButton and event.pressed and $Hand.has_selected()

func draw_card():
	var card = $Deck.draw_card()
	if not card:
		reshuffle()
		card = $Deck.draw_card()
	if card:
		card.flip()
		$Hand.add_card(card)

func attempt_draw():
	if ($Hand.card_count() < 7):
		draw_card()
