extends Control

func set_available(in_deck, total):
	$HBoxContainer/Available.text = String(in_deck)  + "/" + String(total)

func _ready():
	pass
