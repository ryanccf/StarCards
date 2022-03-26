extends Node2D

var spawn_charge = 0
var spawn_max = 30000
var base
var player_base
var Warrior = preload("res://Warrior.tscn")
signal spawn_monster(monster, position)

func set_base(cpu_base):
	base = cpu_base
	
func set_enemy_base(enemy_base):
	player_base = enemy_base
	
func _process(delta):
	if spawn_charge <= spawn_max:
		spawn_charge += 100 * delta * 80
	else:
		spawn_charge = float(int(spawn_charge) % int(100 * delta * 80))
		var monster = Warrior.instance()
#		print("PLAYER BASE: " + str(player_base))
#		print("OPPONENT BASE: " + str(base))
		monster.set_target(player_base)
		monster.set_enemy_base(player_base)
		emit_signal("spawn_monster", monster, base.position)



#			var monster = card.get_monster()
#			monster.set_friendly()
#			for enemy_monster in monsters:
#				if enemy_monster.monster_type == "base":
#					monster.set_target(enemy_monster.position)
#					monster.set_enemy_base(enemy_monster.position)
#			$Background/Field.add_monster(monster, event.position)
