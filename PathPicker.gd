extends Node2D
onready var _rays = $Rays

func set_body(body):
	for ray in _get_rays():
		ray.add_exception(body)

func pick_path():
	for ray in _get_rays():
		if _check_ray(ray):
			return ray.rotation

func _get_rays():
	return [$CenterRay, $NearLeftRay, $NearRightRay, $LeftRay, $RightRay, $FarLeftRay, $FarRightRay]

func _check_ray(ray):
	ray.force_raycast_update()
	return not ray.get_collider()
