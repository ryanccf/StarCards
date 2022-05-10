extends RigidBody2D
var should_stop = false

func stop():
	should_stop = true

func _integrate_forces(state):
	if should_stop:
		should_stop = false
		set_linear_velocity(Vector2.ZERO)
