extends Node

var event_identifier
var story_event
var branches = []

func _ready():
	randomize()

func set_event(identifier, function_reference):
	print(identifier)
	print(function_reference)
	event_identifier = identifier
	story_event = function_reference
	return self

func activate_event(arguments = []):
	print(story_event)
	if story_event:
		return story_event.call_funcv(arguments)

func add_branch(story_leaf):
	branches.push_back(story_leaf)
	return story_leaf

func get_branches():
	return branches

func get_random_branch():
	var randomized_branches = branches.duplicate()
	randomized_branches.shuffle()
	return randomized_branches[0] if randomized_branches.size() > 0 else null

func dehydrate():
	var state = {
		"event_identifier" : event_identifier,
		"children" : []
	}

	for branch in branches:
		state.children.push_back(branch.dehydrate())

	return state
