extends Node

@export var _character: Node
@export var _label: Label
@export var _bar: Slider

# Called when the node enters the scene tree for the first time.
func _ready():
	_label.update_text(_character.level, _character.experience, _character.exp_required)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if not event.is_action_pressed("ui_accept"):
		return
	_character.gain_exp(50)
	_label.update_text(_character.level, _character.experience, _character.exp_required)
