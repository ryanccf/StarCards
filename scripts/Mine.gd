extends Node2D

signal boom(position)

var _friendly = true
var _damage = 20

func _on_Area2D_area_entered(area):
	if area.has_method("take_damage") and not is_aligned_with(area):
		emit_signal("boom", position)
		queue_free()

func set_friendly(friendliness = true):
	_friendly = friendliness

func is_aligned_with(node):
	if node.has_method("is_friendly"):
		return _friendly == node.is_friendly()

func set_damage(damage):
	_damage = damage

func _ready():
	pass
