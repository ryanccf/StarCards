extends "res://TextureStretcher.gd"
var ArcherCard = preload("res://cards/Archer.tscn")
var BarbarianCard = preload("res://cards/Barbarian.tscn")
var DefenderCard = preload("res://cards/Defender.tscn")
var WarriorCard = preload("res://cards/Warrior.tscn")

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var prize_card_names = []
	var actual_prize_cards = []
	var potential_prizes = Global.get_canonical_card_list()
	for i in 3:
		var prize_name = potential_prizes[rng.randi_range(0, potential_prizes.size() - 1)]
		prize_card_names.push_back(prize_name)
	for prize_card_name in prize_card_names:
		var actual_card
		match(prize_card_name):
			"Archer" :
				actual_card = ArcherCard.instance()
			"Barbarian" :
				actual_card = BarbarianCard.instance()
			"Defender" :
				actual_card = DefenderCard.instance()
			"Warrior" : 
				actual_card = WarriorCard.instance()
		actual_prize_cards.push_back(actual_card)
	var i = 0
	for prize in $ContentAnchor/Prizes.get_children():
		prize.set_card(actual_prize_cards[i])
		prize.set_card_name(prize_card_names[i])
		i += 1

func _on_Button_pressed():
	get_tree().change_scene("res://LevelMap.tscn")
