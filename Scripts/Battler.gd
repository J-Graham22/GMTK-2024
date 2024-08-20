extends Marker2D

class_name Battler

export var TARGET_OFFSET_DIST: float = 120.0

onready var stats: CharacterStats = $Job/Stats
onready var lifebar_anchor = $InterfaceAnchor
onready var skin = $Skin
onready var actions = $Actions

var target_global_pos: Vector2

var selected: bool = false setget set_selected
var selectable: bool = false

export var party_member: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func take_turn(target: Battler, action):
	yield(skin.move_forward(), "completed")
	action.execute(self, target)
	yield(skin.move_to(target), "completed")
	yield(get_tree().create_timer(1.0), "timeout")
	yield(skin.return_to_start(), "completed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
