extends Node2D

var first_tick = true
var second_tick = false

func _ready():
	execute()

func execute():
	pass

func _process(delta):
	$Sprite.modulate = $Sprite.modulate + Color(1, 0, 0, delta * -1)
	if first_tick:
		first_tick = false
		second_tick = true
	elif second_tick:
		for area in $Area2D.get_overlapping_areas():
			if area.has_method("set_laser_damage"):
				area.set_laser_damage(area.get_laser_damage() * 2)
		second_tick = false

func _on_Timer_timeout():
	queue_free()
