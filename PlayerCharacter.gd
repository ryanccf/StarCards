extends Node2D

var maxHP = 10 
var currentHP = maxHP

# Called when the node enters the scene tree for the first time.
func _ready():
	update_hp()

func update_hp():
	$HP.text = String(currentHP) + "/" + String(maxHP)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_death()

func check_death():
	if currentHP <= 0:
		print("The Death of a Player Character. ;'-(")
		queue_free()

# This guy is temporary.
func _on_Poison_timeout():
	currentHP -= 1
	update_health_bar_size()

func update_health_bar_size():
	$HealthBar.rect_size.x = currentHP
	update_hp()
