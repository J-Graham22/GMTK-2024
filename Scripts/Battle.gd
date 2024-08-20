extends Control

signal textbox_closed

@export var enemy: Resource = null

var current_henry_health = 0
var current_enemy_health = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_health(GlobalState.current_health, GlobalState.max_health, $PlayerPanel/PlayerData/PlayerPanel/HBoxContainer/CharacterHPList/HenryHP)
	
	current_henry_health = GlobalState.current_health
	current_enemy_health = enemy.health
	$Enemies/Enemy1.texture = enemy.texture
	
	$Textbox.hide()
	$PlayerPanel/PlayerData/ActionsPanel.hide()

	display_text("A group of wild enemies appear!")
	await textbox_closed
	$PlayerPanel/PlayerData/ActionsPanel.show()

func display_text(text: String):
	$Textbox/Label.text = text
	$Textbox.show()
	
func set_health(health: int, max_health: int, health_label: Label):
	health_label.text = "HP %d / %d" % [health, max_health]

func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")

func _on_run_pressed():
	display_text("You got away safely!")
	await textbox_closed
	get_tree().quit()


func _on_attack_pressed():
	display_text("You swing your mighty sword!")
	await textbox_closed
	
	current_enemy_health = max(0, current_enemy_health - GlobalState.atk)
	
	$AnimationPlayer.play("enemy_damaged")
	await $AnimationPlayer.animation_finished
	
	if current_enemy_health == 0:
		display_text("You felled the enemy %s!" % enemy.name)
		await textbox_closed
		
		$AnimationPlayer.play("enemy_died")
		await $AnimationPlayer.animation_finished
		await get_tree().create_timer(0.5).timeout
		get_tree().quit()
	
	enemy_turn()
	
func enemy_turn():
	display_text("%s lunges toward you dangerously!" % enemy.name)
	await textbox_closed
	
	current_henry_health = max(0, current_henry_health - enemy.atk)
	set_health(current_enemy_health, GlobalState.max_health, $PlayerPanel/PlayerData/PlayerPanel/HBoxContainer/CharacterHPList/HenryHP)
	
	$AnimationPlayer.play("screen_shake")
	await $AnimationPlayer.animation_finished
