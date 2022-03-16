extends Area2D
signal damage_taken(amount)
var friendly = false

func take_damage(damage):
	emit_signal("damage_taken", damage)
	
func set_friendly(friendliness = true):
	friendly = friendliness

func is_friendly():
	return friendly
