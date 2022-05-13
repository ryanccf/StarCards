extends Node2D

var rng = RandomNumberGenerator.new()
var spawn_charge = 0
var spawn_max = 30000
var base
var player_base
var spawn_point
var Warrior = preload("res://monsters/Warrior.tscn")
var Defender = preload("res://monsters/Defender.tscn")
var Archer = preload("res://monsters/Archer.tscn")
var monsters = []
var monster_slots = 0
signal spawn_monster(monster, position)

func _ready():
	rng.randomize()
	initialize_monsters()

func _process(delta):
	update_battle_arrays()
	manage_monster_spawning(delta)

func initialize_monsters():
	monsters.append(Warrior.instance())
	monsters.append(Warrior.instance())
	monsters[0].position = Vector2(950, 200)
	monsters[1].position = Vector2(1100, 401)
	monsters[0].set_monster_type("base")
	monsters[1].set_monster_type("fighter")
	monsters[1].set_target(player_base)
	for monster in monsters:
		monster.set_enemy_base(player_base)
		monster.set_color(Color(20,0,0))
		emit_signal("spawn_monster", monster, monster.position)

func update_battle_arrays():
	for monster in monsters:
		if !is_instance_valid(monster):
			monsters.erase(monster)

func manage_monster_spawning(delta):
	if spawn_charge <= spawn_max:
		spawn_charge += 100 * delta * 80
	else:
		spawn_charge = float(int(spawn_charge) % int(100 * delta * 80))
		spawn_monster()

func spawn_monster():
	monster_slots += 1
	try_to_spawn()

func spawn_one_ship():
	var monster = Warrior.instance()
	monster_slots -= 1
	monster.set_target(player_base)
	monster.set_enemy_base(player_base)
	monster.set_color(Color(20,0,0))
	determine_spawn_point()
	emit_signal("spawn_monster", monster, spawn_point)

func spawn_two_ships():
	var monster1 = Archer.instance()
	var monster2 = Defender.instance()
	monster_slots -= 2
	monster1.set_target(player_base)
	monster2.set_target(player_base)
	monster1.set_enemy_base(player_base)
	monster2.set_enemy_base(player_base)
	monster1.set_color(Color(20,0,0))
	monster2.set_color(Color(20,0,0))
	determine_spawn_point()
	emit_signal("spawn_monster", monster1, spawn_point)
	emit_signal("spawn_monster", monster2, spawn_point)

func try_to_spawn():
	var monster = Warrior.instance()
	match(decide_to_wait()):
		"":
			print("wait")
			pass
		"one":
			print("one")
			spawn_one_ship()
		"all":
			print("two")
			spawn_two_ships()

func decide_to_wait():
	match (rng.randi_range(0, 3)):
		0:
			return ""
		1:
			return ""
		2:
			return "one"
		3:
			return "all"

func determine_spawn_point():
	set_spawn(monsters[0].position)
	match (rng.randi_range(0, 1)):
		0:
			set_spawn(spawn_point + Vector2(0, 200))
		1:
			set_spawn(spawn_point + Vector2(0, -200))

func set_spawn(target):
	spawn_point = target

func set_base(cpu_base):
	base = cpu_base

func has_base():
	for monster in monsters:
		if weakref(monster).get_ref() and monster.monster_type == "base":
			return true

func get_base():
	for monster in monsters:
		if weakref(monster).get_ref() and monster.monster_type == "base":
			return monster

func set_enemy_base(enemy_base):
	player_base = enemy_base
