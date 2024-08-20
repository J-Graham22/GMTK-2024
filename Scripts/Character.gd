extends Node

#character stats
@export var max_hp: int = 12
@export var strength: int = 8
@export var magic: int = 8

#leveling system
@export var level: int = 1

var experience: int = 0
var exp_total: int = 0
var exp_required: int = get_required_exp(level + 1)

func get_required_exp(level: int) -> int:
	return round(pow(level, 1.8) + 4*level + 8)

func gain_exp(exp_num: int):
	exp_total += exp_num
	experience += exp_num
	while experience >= exp_required:
		experience -= exp_required
		level_up()

func level_up():
	level += 1
	exp_required = get_required_exp(level + 1)

	var stats: Array = ['max_hp', 'strength', 'magic']

	var rand_stat = stats[randi() % stats.size()]
	set(rand_stat, get(rand_stat) + (randi() % 4 + 2))
