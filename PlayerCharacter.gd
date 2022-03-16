extends Node2D

var maxHP = 10
var currentHP = maxHP
var maxSpeed = 10000
var playerSpeed = 50
var currentSpeed = 0

signal turn_complete
signal death

func _ready():
	update_hp()

func update_hp():
	$HP.text = String(currentHP) + "/" + String(maxHP)	

func scale_sprite(amount):
	$Sprite.set_scale(amount)

func increase_speed(amount):
	playerSpeed += amount

func update_speed(delta):
	if currentSpeed <= maxSpeed:
		currentSpeed += playerSpeed * delta * 80
	else:
		currentSpeed = float(int(currentSpeed) % int(playerSpeed * delta * 80))
		emit_signal("turn_complete")
	update_speed_bar_size()

func update_graphic(new_graphic):
	$Sprite.set_texture(new_graphic)

func _process(delta):
	update_speed(delta)
	check_death()

func check_death():
	if currentHP <= 0:
		emit_signal("death")
		queue_free()

# This guy is temporary.
func _on_Poison_timeout():
	currentHP -= 1
	update_health_bar_size()

func update_health_bar_size():
	$HealthBar.rect_size.x = float(float(currentHP)/float(maxHP) * 10.0)
	update_hp()

func update_speed_bar_size():
	$SpeedBar.rect_size.x = float(float(currentSpeed)/float(maxSpeed) * 10.0)
