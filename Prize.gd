extends Control
signal add_to_library(card)
signal add_to_deck(card)
signal exit

var card
var card_name

func set_card(new_card):
	$CardAnchor.add_child(new_card)
	card = new_card
	#card.position = Vector2.ZERO
	

func set_card_name(new_card_name):
	card_name = new_card_name

func _on_AddToLibrary_pressed():
	_add_to_library_and_exit()

func _on_AddToDeck_pressed():
	Global.get_decks()[0].add_card(card_name)
	_add_to_library_and_exit()

func _add_to_library_and_exit():
	Global.add_card(card_name)
	get_tree().change_scene("res://LevelMap.tscn")
