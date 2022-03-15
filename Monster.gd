extends Node2D

var maxHP = 10 
var currentHP = maxHP
var monster_name = "base";
var monster_type;

# Called when the node enters the scene tree for the first time.
func _ready():
	update_hp()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_death()

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
