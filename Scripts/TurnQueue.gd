extends Node2D

class_name TurnQueue

onready var current_character: Battler

func initialize():
	var battlers = get_battlers()
	battlers.sort_custom(self, 'sort_battlers')
	for battler in battlers:
		battler.raise()
	current_character = get_child(0)

static func sort_battlers(a: Battler, b: Battler) -> bool:
	return a.stats.speed > b.stats.speed

func take_turn():
	yield(current_character.take_turn(), "completed")
	var new_character_idx: int = (current_character.get_index() + 1) % get_child_count()
	current_character = get_child(new_character_idx)
