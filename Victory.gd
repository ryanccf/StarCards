extends "res://TextureStretcher.gd"

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var prize_cards = []
	var potential_prizes = Global.get_canonical_card_list()
	for i in 3:
		var prize_name = potential_prizes[rng.randi_range(0, potential_prizes.size() - 1)]
		prize_cards.push_back(prize_name)
	print(prize_cards)
	#Global.add_card(prize_name)

func _process(_delta):
	pass
#	check_click()

#func check_click():
#	if Input.is_action_pressed("click"):
#		get_tree().change_scene("res://LevelMap.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://LevelMap.tscn")
