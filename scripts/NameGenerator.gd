extends Node2D

var prefixes = ["Alpha ", "Beta ", "Gamma ", "Zeta "]
var middle_parts = ["Centauri ", "Cerebra ", "Reticulon "]
var postfixes = ["", "Major ", "Minor "]
var word_lists = [prefixes, middle_parts, postfixes]
var used_names = []
var rng = RandomNumberGenerator.new()
var decimal_to_roman_map = {
	"1" : "I",
	"2" : "II",
	"3" : "III",
	"4" : "IV",
	"5" : "V",
	"6" : "VI",
	"7" : "VII",
	"8" : "VIII",
	"9" : "IX",
	"10" : "X",
	"11" : "XI",
	"12" : "XII",
	"13" : "XIII",
	"14" : "XIV",
	"15" : "XV",
	"16" : "XVI",
	"17" : "XVII",
	"18" : "XVIII",
	"19" : "XIX",
	"20" : "XX"
}
var roman_to_decimal_map = {
	"I" : "1",
	"II" : "2",
	"III" : "3",
	"IV" : "4",
	"V" : "5",
	"VI" : "6",
	"VII" : "7",
	"VIII" : "8",
	"IX" : "9",
	"X" : "10",
	"XI" : "11",
	"XII" : "12",
	"XIII" : "13",
	"XIV" : "14",
	"XV" : "15",
	"XVI" : "16",
	"XVII" : "17",
	"XVIII" : "18",
	"XIX" : "19",
	"XX" : "20"
}

func get_name():
	var name = ""
	randomize()
	for word_list in word_lists:
		word_list.shuffle()
		name += word_list[0]
	while name in used_names:
		name = _increment_number(name)
	used_names.push_back(name)
	return name

func _increment_number(name):
	return _trim_roman(name) + _get_roman(_get_number(name) + 1)

func _trim_roman(name):
	while not name.ends_with(" "):
		name = name.substr(0, len(name) - 1)
	return name

func _get_number(name):
	var roman = ""
	var roman_chars = []

	if name.ends_with(" "):
		name += "I"
	
	while not name.ends_with(" "):
		roman_chars.push_front(str(name.substr(len(name) - 1, 1)))
		name = name.substr(0, len(name) - 1)

	for character in roman_chars:
		roman += character

	return int(roman_to_decimal_map[roman])

func _get_roman(number):
	return decimal_to_roman_map[str(number)]

func _reverse(string):
	var reversed = ""
	for i in range(len(string)):
		reversed += string[-1 * i]
	return reversed
