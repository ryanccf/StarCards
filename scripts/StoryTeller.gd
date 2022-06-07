extends Node
signal sotry_event(return_value)

var StoryBranch = preload("res://Utilities/StoryBranch.tscn")
var story_roots = []
var current_branch
var story_charge = 0
var story_max = 10000

func first_event():
	#print("FIRST EVENT")
	pass

func second_event():
	#print("SECOND EVENT")
	pass

func third_event():
	#print("THIRD EVENT")
	pass

func _ready():
	
	var events = [
		funcref(self, "first_event"),
		funcref(self, "second_event"),
		funcref(self, "third_event")
	]
	
	current_branch = StoryBranch.instance().set_event(events[0])
	current_branch.add_branch(StoryBranch.instance()).set_event(events[1]).add_branch(StoryBranch.instance()).set_event(events[2])

func _process(delta):
	if story_charge <= story_max:
		story_charge += 100 * delta * 20
	elif current_branch:
		story_charge = float(int(story_charge) % int(100 * delta * 80))
		emit_signal("story_event", current_branch.activate_event())
		current_branch = current_branch.get_random_branch()
