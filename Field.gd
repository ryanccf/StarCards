extends Area2D

var monsters = []
var Laser = preload("res://Laser.tscn")
var DirectAttack = preload("res://Actions/DirectAttack.tscn")

func add_monster(monster, position):
	add_child(monster)
	monster.set_position(position)
	monster.set_bounds($Bounds)
	monster.connect("spawn_laser", self, "_handle_laser_spawn")
	monster.connect("boom", self, "_handle_boom")
	
	
func _handle_laser_spawn(laser_position, laser_rotation, laser_target, is_friendly):
	var laser = Laser.instance()
	laser.position = laser_position
	laser.rotation = laser_rotation
	laser.set_target(laser_target)
	laser.set_friendly(is_friendly)
	laser.connect("target_reached", self, "_clean_up_laser")
	add_child(laser)

func _handle_boom(position):
	for _i in 3:
		var direct_attack = DirectAttack.instance()
		direct_attack.position = position
		add_child(direct_attack)
	
func _clean_up_laser(laser):
	pass
