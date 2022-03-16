extends Node2D

var maxHP = 10 
var currentHP = maxHP
var monster_name = "base";
var monster_type;
var friendly = false
var speed = 55
var current_target
var enemy_base
var enemy_trackers = [$ShootingZone, $SensingZone]

# Called when the node enters the scene tree for the first time.
func _ready():
	update_hp()
	$HitZone.connect("damage_taken", self, "take_damage")
	$HitZone.set_friendly(is_friendly())
	$ShootingZone.connect("target_enters", self, "handle_new_focus_in_shooting_zone")
	$ShootingZone.connect("target_leaves", self, "handle_target_leaving_shooting_zone")
	$SensingZone.connect("target_enters", self, "handle_new_focus_in_sensing_zone")
	$SensingZone.connect("target_leaves", self, "handle_new_target_in_sensing_zone")
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_death()
	move(delta)

func set_target(target):
	current_target = target
	
func set_enemy_base(base):
	enemy_base = base

func move(delta):
	_point_to_nearest_target()
	if monster_type != "base" and current_target:
		look_at(current_target)
		if not $ShootingZone.has_target():
			position += speed * delta * Vector2(cos(rotation), sin(rotation))
	
func set_friendly(friendliness = true):
	friendly = friendliness
	$HitZone.set_friendly(friendliness)
	$ShootingZone.set_friendly(friendliness)
	$SensingZone.set_friendly(friendliness)

func is_friendly():
	return friendly
	
func is_aligned_with(monster):
	return is_friendly() == monster.is_friendly()

func set_monster_type(the_type):
	monster_type = the_type

func update_hp():
	$HP.text = String(currentHP) + "/" + String(maxHP)	

func check_death():
	if currentHP <= 0:
		print("An Enemy dies.")
		queue_free()

func _on_Poison_timeout():
	currentHP -= 1
	update_health_bar_size()

func update_health_bar_size():
	$HealthBar.rect_size.x = float(float(currentHP)/float(maxHP) * 100)
	update_hp()

func _point_to_nearest_target():
	set_target(_find_nearest_target() if _has_target() else enemy_base)

func _find_nearest_target():
	return $SensingZone.get_nearest_target()

func _has_target():
	return $SensingZone.has_target()

func handle_new_focus_in_shooting_zone(position):
	pass

func handle_target_leaving_shooting_zone(position):
	pass

func handle_new_focus_in_sensing_zone(position):
	pass

func handle_new_target_in_sensing_zone(position):
	pass
