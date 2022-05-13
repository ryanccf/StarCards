extends Area2D
signal damage_taken(amount)
var friendly = false

func take_damage(damage):
	emit_signal("damage_taken", damage)
	
func set_friendly(friendliness = true):
	friendly = friendliness

func is_friendly():
	return friendly

func get_laser_damage():
	return get_parent().get_laser_damage()

func set_laser_damage(x):
	return get_parent().set_laser_damage(x);
