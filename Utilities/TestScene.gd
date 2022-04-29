extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var name = "frank "
	var roman = ""
	var roman_chars = []
	name = str(name)
	print(name)
	print(name.ends_with(" "))
	if name.ends_with(" "):
		name = name + "I"
	
	while not name.ends_with(" "):
		roman_chars.push_back(str(name.substr(len(name) - 1, 1)))
		name = name.substr(0, len(name) - 1)

	for character in roman_chars:
		roman += character
	print(roman)
	print("done")
