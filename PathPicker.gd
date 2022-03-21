extends Node2D

func set_body(body):
	for ray in [$CenterRay, $NearLeftRay, $NearRightRay, $FarLeftRay, $FarRightRay]:
		ray.add_exception(body)

func pick_path():
	var best_rotation = null
	
	if _check_ray($CenterRay):
		best_rotation = 0
	elif _check_ray($NearLeftRay):
		best_rotation = -1/float(3)*PI
	elif _check_ray($NearRightRay):
		best_rotation = 1/float(3)*PI
	elif _check_ray($FarLeftRay):
		best_rotation = -2/float(3)*PI
	elif _check_ray($FarRightRay):
		best_rotation = 2/float(3)*PI

	return best_rotation

func _check_ray(ray):
	ray.force_raycast_update()
	return not ray.get_collider()
