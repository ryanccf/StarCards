extends Area2D

var monsters = []
var Laser = preload("res://Laser.tscn")


func add_monster(monster, position):
	add_child(monster)
	monster.set_position(position)
	monster.connect("spawn_laser", self, "_handle_laser_spawn")
	
func _handle_laser_spawn(laser_position, laser_rotation):
	var laser = Laser.instance()
	add_child(laser)
	laser.position = laser_position
	laser.rotation = laser_rotation
