extends Node2D

var prefixes = ["Alpha ", "Beta "]
var middle_parts = ["Centauri ", "Cerebra "]
var postfixes = ["", "IV"]
var word_lists = [prefixes, middle_parts, postfixes]
var rng = RandomNumberGenerator.new()

func get_name():
	var name = ""
	randomize()
	for word_list in word_lists:
		word_list.shuffle()
		name += word_list[0]
	return name
