extends Node
signal story_event

var StoryBranch = preload("res://Utilities/StoryBranch.tscn")
var story_roots = []
var current_branch
var story_charge = 0
var story_max = 10000

func first_event():
	print("FIRST EVENT")
	pass

func second_event():
	print("SECOND EVENT")
	pass

func third_event():
	print("THIRD EVENT")
	pass

func _ready():
	current_branch = StoryBranch.instance().set_event("first_event", get_event("first_event"))
	var second_branch = add_branch_get_child(current_branch, "second_event")
	var third_branch = add_branch_get_child(second_branch, "third_event")

func _process(_delta):
	if story_charge <= story_max:
		story_charge += 100 * Global.get_time() * 5
	elif current_branch:
		story_charge = float(int(story_charge) % int(100 * Global.get_time() * 5))
		var event_output = current_branch.activate_event()
		current_branch = current_branch.get_random_branch()
		emit_signal("story_event")#, event_output)

func add_branch_get_child(parent, identifier):
	return parent.add_branch(StoryBranch.instance().set_event(identifier, get_event(identifier)))

func add_branch_get_parent(parent, identifier):
	parent.add_branch(StoryBranch.instance().set_event(identifier, get_event(identifier)))
	return parent

func get_event(identifier):
	return funcref(self, identifier) 

func dehydrate():
	return {
		"name" : "Default StoryTeller",
		"story_tree" : current_branch.dehydrate() if current_branch else null
	}

func rehydrate(state):
	if state.story_tree:
		current_branch = rehydrate_children(StoryBranch.instance().set_event(state.story_tree.event_identifier, get_event(state.story_tree.event_identifier)), state.story_tree.children)

func rehydrate_children(branch, children):
	for child in children:
		rehydrate_children(add_branch_get_child(branch, child.event_identifier), child.children)
	return branch
