extends Node2D

var maxHP = 10 
var currentHP = maxHP
var monster_name = "base";
var monster_type;
var friendly = false
var speed = 55 * 100
var current_target
var enemy_base
var bounds
var laser_charge = 0
var laser_max = 10000
onready var sensing_zone = $SensingZone
onready var shooting_zone = $ShootingZone
var middle

signal spawn_laser(laser)

func _ready():
	update_hp()
	$StabilizedAnchor/HealthBar.rect_position.y -= 45
	$HitZone.connect("damage_taken", self, "take_damage")
	$HitZone.set_friendly(is_friendly())
	$ObstacleAvoider.add_exception($KinematicBody2D)

func _physics_process(delta):
	_check_death()
	_rotate()
	if _should_move():
		_avoid_obstacles()
		move(delta)
	else:
		$RigidShipBody.stop()
	_check_lasers(delta)
	_stabilize_health_bar()
	sync_body()

func set_target(target):
	current_target = target

func get_target():
	return current_target if current_target else global_position
	
func set_enemy_base(base):
	enemy_base = base

func _rotate():
	_point_to_locked_target()
	look_at(get_target())

func _should_move():
	return monster_type != "base" and current_target and not $ShootingZone.has_target()
	
func _avoid_obstacles():
	var path_rotation = $ObstacleAvoider.get_viable_rotation()
	if path_rotation != null:
		rotation += path_rotation

func move(delta):
	$RigidShipBody.set_velocity(speed * delta * Vector2(cos(rotation), sin(rotation)))
	$RigidShipBody.gravity_scale = 0
#	$RigidShipBody.apply_impulse(Vector2.ZERO, speed * delta * Vector2(cos(rotation), sin(rotation)))#* 0.0001)#cos(rotation), sin(rotation)))
	global_position = $RigidShipBody.global_position
	$RigidShipBody.position = Vector2(0, 0)
	rotation += $RigidShipBody.rotation 
	$RigidShipBody.rotation = 0

func sync_body():
	global_position = $RigidShipBody.global_position
	$RigidShipBody.position = Vector2(0, 0)
	rotation += $RigidShipBody.rotation 
	$RigidShipBody.rotation = 0
	

	#collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
	#var collision = $KinematicBody2D.move_and_collide(speed * delta * Vector2(cos(rotation), sin(rotation)))
	#global_position = $KinematicBody2D.global_position
	#$KinematicBody2D.position = Vector2(0, 0)
	#rotation += $KinematicBody2D.rotation 
	#$KinematicBody2D.rotation = 0
	


func set_friendly(friendliness = true):
	friendly = friendliness
	$HitZone.set_friendly(friendliness)
	$ShootingZone.set_friendly(friendliness)
	$SensingZone.set_friendly(friendliness)

func set_color(color):
	$Sprite.modulate = color

func is_friendly():
	return friendly
	
func is_aligned_with(monster):
	return is_friendly() == monster.is_friendly()

func set_monster_type(the_type):
	monster_type = the_type

func update_hp():
	$HP.text = String(currentHP) + "/" + String(maxHP)	

func _check_death():
	if currentHP <= 0:
		seppuku()

func seppuku():
	if(get_parent()):
		get_parent().remove_child(self)
	queue_free()

func _check_lasers(delta):
	if laser_charge <= laser_max:
		laser_charge += 100 * delta * 80
	elif $ShootingZone.has_target():
		laser_charge = float(int(laser_charge) % int(100 * delta * 80))
		emit_signal("spawn_laser", position, rotation, current_target, friendly)

func update_health_bar_size():
	$StabilizedAnchor/HealthBar.rect_size.x = float(float(currentHP)/float(maxHP) * 100)
	update_hp()

func _point_to_locked_target():
	if weakref(enemy_base).get_ref():
		set_target(_find_locked_target() if _has_target() and not $ShootingZone.has_specific_target(enemy_base) else enemy_base.global_position)

func _find_locked_target():
	return ($ShootingZone.get_locked_target() if $ShootingZone.has_target() else $SensingZone.get_locked_target())

func _has_target():
	return $SensingZone.has_target()

func take_damage(damage):
	currentHP -= damage
	if currentHP > maxHP:
		currentHP = maxHP
	update_health_bar_size()

func update_graphic(new_graphic):
	$Sprite.set_texture(new_graphic)

func _stabilize_health_bar():
	$StabilizedAnchor.rotation = -1 * rotation
	$StabilizedAnchor.global_position.x = global_position.x
	$StabilizedAnchor.global_position.y = global_position.y# - 45

func set_bounds(bounds_area):
	bounds = bounds_area

func out_of_bounds():
	return bounds in $HitZone.get_overlapping_areas()

func set_middle(new_middle):
	middle = new_middle
