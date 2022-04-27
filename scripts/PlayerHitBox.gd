extends Area2D
signal damage(damage)

func is_friendly():
	return true
	
func take_damage(damage):
	emit_signal("damage", damage)
