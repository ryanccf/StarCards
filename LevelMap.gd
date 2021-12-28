extends Node2D

var screen_height = OS.get_real_window_size().y
var Location = preload("res://Location.tscn") 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	generate_level()

func generate_level():
	var start = Location.instance()
	add_child(start)
	start.position.x = 120
	start.position.y = screen_height / 2
	# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
