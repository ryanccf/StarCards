extends Node2D

var time_elapsed = 0.0

func _ready():
	time_elapsed = Global.get_time()
	pass

func _process(delta):
	add_time(delta)
	Global.set_time(time_elapsed)

func add_time(time):
	time_elapsed += time
	
func get_time():
	#print(time_elapsed)
	return int(time_elapsed)

func get_exact_time():
	return time_elapsed
