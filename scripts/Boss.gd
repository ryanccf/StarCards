extends "res://scripts/Opponent.gd"

func initialize():
	StartingMonsterClass = Barbarian
	rng.randomize()
	initialize_monsters()

func _ready():
	monster_group_configurations = [
		{},
		{
			"monsters" : [
				{
					"constructor"  : Barbarian
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
					"constructor"  : Barbarian
				},
				{
					"constructor"  : Barbarian,
					"location" : Vector2(60, -30)
				},
				{
					"constructor"  : Barbarian,
					"location" : Vector2(60, 30)
				},
				{
					"constructor"  : Barbarian,
					"location" : Vector2(120, -60)
				},
				{
					"constructor"  : Barbarian,
					"location" : Vector2(120, 60)
				}
			]
		}
	]
