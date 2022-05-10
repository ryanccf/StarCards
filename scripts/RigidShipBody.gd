extends RigidBody2D
var should_stop = false
var target_velocity = Vector2.ZERO

func set_velocity(new_velocity):
	target_velocity = new_velocity

func stop():
	should_stop = true

func _integrate_forces(state):
#	var velocity = 
	if should_stop:
		should_stop = false
		set_linear_velocity(Vector2.ZERO)
	else:
		set_linear_velocity(target_velocity)
