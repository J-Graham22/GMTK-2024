extends Label

func update_text(level: int, experience: int, exp_required: int):
	text = """Lvl: %s
			Experience: %s
			Nxt Lvl: %s
	""" % [level, experience, exp_required]
