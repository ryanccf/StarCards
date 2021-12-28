extends Node2D

var counter = 1000
var card_id_counter = 0

var Card = preload("res://Card.tscn")
var Stack = preload("res://Stack.tscn")
var selected = false
var deck = Stack.instance()
var hand = Stack.instance()  

onready var Count = $Background/Count

func _ready():
	randomize()
	initial_state()
	
func _on_HitButton_pressed():
	$Background.add_child(deck.draw_card())

func assign_card_id():
	card_id_counter += 1
	return card_id_counter

func initial_state():
	var suits = ["clubs", "diamonds", "hearts", "spades"]
	var ranks = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "ace", "jack", "king", "queen"]
	for suit in suits:
		for rank in ranks:
			var card = Card.instance()
			var card_name = rank + "_of_" + suit
			card.set_id(card_name)
			var my_filename = "res://card-images/" + card.get_id() + ".png"
			card.load_texture(my_filename)
			deck.add_card(card)
	deck.shuffle()
