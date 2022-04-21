extends Control

const MIN_COLOR = 0
const MAX_COLOR = 60

var ascending = true
var bg_color = Color(0,0,0,1)

func _ready():
	bg_color.r8 = 1

func _process(delta):
	if ascending:
		if bg_color.r8 <= MAX_COLOR:
			bg_color.r8 += delta * 35
			bg_color.b8 += delta * 35
		else:
			ascending = false
	else:
		if bg_color.r8 >= MIN_COLOR:
			bg_color.r8 -= delta * 70
			bg_color.b8 -= delta * 70
		else:
			ascending = true
	$ColorRect.set_frame_color(bg_color)
	if Input.is_action_pressed("click"):
		get_tree().change_scene("res://SaveSelect.tscn")
