extends "res://Monster.gd"
var graphic = load("res://images/station_A.png")
var RayCastDown = load("$StabilizedAnchor/RayCastDown")
var RayCastUp = load("$StabilizedAnchor/RayCastUp")
var last_y_target

func _ready():
	print($StabilizedAnchor/RayCastUp)
	$StabilizedAnchor/RayCastUp.collide_with_areas = true;
	$StabilizedAnchor/RayCastDown.collide_with_areas = true;
	$StabilizedAnchor/RayCastUp.collide_with_bodies = true;
	$StabilizedAnchor/RayCastDown.collide_with_bodies = true;
	._ready()
	maxHP = 100
	speed = 40
	currentHP = maxHP
	update_hp()
	update_graphic(graphic)
	_initialize_spawn_point_marker()

func _physics_process(delta):
	._physics_process(delta)
	_check_raycast()

func _check_lasers(delta):
	pass

func _check_raycast():
	$StabilizedAnchor/RayCastDown.force_raycast_update()
	$StabilizedAnchor/RayCastUp.force_raycast_update()
	if ($StabilizedAnchor/RayCastDown.is_colliding()):
		print($StabilizedAnchor/RayCastDown.get_collider())
	elif ($StabilizedAnchor/RayCastUp.is_colliding()):
		print("Top of the screen")

func _initialize_spawn_point_marker():
	remove_child($SpawnPointMarker)
	get_parent().add_child($SpawnPointMarker)
	last_y_target = 9000

func _point_to_locked_target():
	var x
	var y
	
	if out_of_bounds():
		print(position.y)
		if position.y > 100:
			y = 0
			print("negative 9000")
		else:
			print("positive 9000")
			y = 9000
		last_y_target = y
	else:
		y = last_y_target


	x = global_position.x#$SpawnPointMarker.global_position.x
	set_target(Vector2(x, y))

func _check_death():
	if currentHP <= 0:
		if(get_parent()):
			get_parent().remove_child(self)
			#get_parent().remove_child($SpawnPointMarker)
		queue_free()
