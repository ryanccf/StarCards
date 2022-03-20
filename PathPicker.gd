extends Node2D

var best_path
var rays = [$CenterRay, $NearLeftRay, $NearRightRay, $FarLeftRay, $FarRightRay]

func pick_path():
	best_path = null
	for ray in rays:
		_check_ray(ray)
	return best_path

func _check_ray(ray):
	if not best_path:
		ray.force_raycast_update()
		best_path = ray.get_cast_to() if not ray.get_collider() else false
