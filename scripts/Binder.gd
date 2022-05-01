extends Node2D

var bound_values
var function_reference

func bind(new_function_reference, values = []):
	bound_values = values
	function_reference = new_function_reference
	return funcref(self, "_call")

func _call():
	function_reference.call_funcv(bound_values)
