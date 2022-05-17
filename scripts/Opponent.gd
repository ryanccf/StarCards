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
var Barbarian = preload("res://monsters/Barbarian.tscn")
var Wedge = preload("res://monsters/Wedge.tscn")
var Scoop = preload("res://monsters/Scoop.tscn")
var StartingMonsterClass = Warrior
var monsters = []
var monster_slots = 0
var random_location_generator = funcref(self, "determine_spawn_point")
var base_defending_location_generator = funcref(self, "get_defensive_position")
signal spawn_monster(monster, position)

var monster_group_configurations = [
	{},
	{},
	{},
	{},
	{
		"monsters" : [
			{
				"constructor"  : Warrior
			}
		]
	},
	{
		"location_generator" : base_defending_location_generator,
		"monsters" : [
			{
				"constructor"  : Defender
			},
			{
				"constructor"  : Archer
			}
		]
	},
	{
		"monsters" : [
			{
				"constructor"  : Barbarian
			},
			{
				"constructor"  : Barbarian,
				"location" : Vector2(60, -30)
			},
			{
				"constructor"  : Barbarian,
				"location" : Vector2(60, 30)
			}
		]
	},
	{
		"monsters" : [
			{
				"constructor"  : Wedge
			}
		]
	},
	{
		"monsters" : [
			{
				"constructor"  : Scoop
			}
		]
	},
	{
		"monsters" : [
			{
				"constructor"  : Barbarian
			}
		]
	},
	{
		"monsters" : [
			{
				"constructor"  : Warrior
			},
			{
				"constructor"  : Warrior,
				"location" : Vector2(60, -30)
			},
			{
				"constructor"  : Warrior,
				"location" : Vector2(60, 30)
			},
			{
				"constructor"  : Warrior,
				"location" : Vector2(120, -60)
			},
			{
				"constructor"  : Warrior,
				"location" : Vector2(120, 60)
			}
		]
	}
]

#func _ready():
#	rng.randomize()
#	initialize_monsters()

func initialize():
	rng.randomize()
	initialize_monsters()

func _process(delta):
	update_battle_arrays()
	manage_monster_spawning(delta)

func set_starting_monster_class(Constructor):
	StartingMonsterClass = Constructor

func initialize_monsters():
	monsters.append(Warrior.instance())
	monsters.append(StartingMonsterClass.instance())
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
		#spawn_monster()
		choose_group_to_place(monster_group_configurations)

func choose_group_to_place(monster_group_configurations):
	monster_slots += 1
	var valid_groups = []
	for group in monster_group_configurations:
		if not group.has("monsters"):
			valid_groups.push_back([])
		elif group.monsters.size() <= monster_slots:
			valid_groups.push_back(group)
	if valid_groups.size() > 0:
		place_monsters(valid_groups[rng.randi_range(0, valid_groups.size() - 1)])

func place_monsters(monster_group_configuration):
	var group_offset = get_group_location_offset(monster_group_configuration)
	for monster_configuration in get_monsters(monster_group_configuration):
		var location = group_offset + get_monster_location_offset(monster_configuration)
		place_monster(monster_configuration.constructor, location)

func get_group_location_offset(monster_group_configuration):
	return generate_location_offset(monster_group_configuration.location_generator) if monster_group_configuration.has("location_generator") else determine_spawn_point()

func get_monsters(monster_group_configuration):
	return monster_group_configuration.monsters if monster_group_configuration.has("monsters") else []

func get_monster_location_offset(monster_configuration):
	return monster_configuration.location if monster_configuration.has("locaiton") else Vector2.ZERO

func generate_location_offset(location_generator):
	return location_generator.call_func() if location_generator and location_generator.has_method("is_valid") and location_generator.is_valid() else 0

func place_monster(MonsterClass, location):
	var monster = MonsterClass.instance()
	monster_slots -= 1
	monster.set_target(player_base)
	monster.set_enemy_base(player_base)
	monster.set_color(Color(20,0,0))
	emit_signal("spawn_monster", monster, location)

func determine_spawn_point():
	set_spawn(monsters[0].position)
	match (rng.randi_range(0, 1)):
		0:
			set_spawn(spawn_point + Vector2(0, 200))
		1:
			set_spawn(spawn_point + Vector2(0, -200))
	return spawn_point

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

func get_defensive_position():
	return get_base().position - Vector2(200, 0) if get_base() else Vector2(1100, 0)
	

func set_enemy_base(enemy_base):
	player_base = enemy_base

#func spawn_monster():
#	monster_slots += 1
#	try_to_spawn()

#func spawn_one_ship():
#	var monster = Warrior.instance()
#	monster_slots -= 1
#	monster.set_target(player_base)
#	monster.set_enemy_base(player_base)
#	monster.set_color(Color(20,0,0))
#	determine_spawn_point()
#	emit_signal("spawn_monster", monster, spawn_point)

#func spawn_two_ships():
#	var monster1 = Archer.instance()
#	var monster2 = Defender.instance()
#	monster_slots -= 2
#	monster1.set_target(player_base)
#	monster2.set_target(player_base)
#	monster1.set_enemy_base(player_base)
#	monster1.set_color(Color(20,0,0))
#	monster2.set_color(Color(20,0,0))
#	determine_spawn_point()
#	emit_signal("spawn_monster", monster1, spawn_point)
#	emit_signal("spawn_monster", monster2, spawn_point)

#func try_to_spawn():
#	var monster = Warrior.instance()
#	match(decide_to_wait()):
#		"":
#			print("wait")
#			pass
#		"one":
#			print("one")
#			spawn_one_ship()
#		"all":
#			print("two")
#			spawn_two_ships()

#func decide_to_wait():
#	match (rng.randi_range(0, 3)):
#		0:
#			return ""
#		1:
#			return ""
#		2:
#			return "one"
#		3:
#			return "all"
