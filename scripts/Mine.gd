extends Node2D

var _friendly = true
var _damage = 20

func _on_Area2D_area_entered(area):
	if area.has_method("take_damage") and not is_aligned_with(area):
		area.take_damage(_damage)

func set_friendly(friendliness = true):
	_friendly = friendliness

func is_aligned_with(node):
	if node.has_method("is_friendly"):
		return _friendly == node.is_friendly()

func _ready():
	pass
