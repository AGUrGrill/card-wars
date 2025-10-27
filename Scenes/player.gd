extends Control

@export var PLAYER_NUM = 1

@onready var hp: Label = $HP
@onready var actions: Label = $Actions
var prev_hp = 0
var prev_actions = 0

func _process(delta: float) -> void:
	if PLAYER_NUM == 1:
		if GameManager.player1_hp != prev_hp:
			prev_hp = GameManager.player1_hp
			hp.text = "HP: " + str(prev_hp) 
		if GameManager.player1_actions != prev_actions:
			prev_actions = GameManager.player1_actions
			actions.text = "Actions: " + str(prev_actions) 
	elif PLAYER_NUM == 2:
		if GameManager.player2_hp != prev_hp:
			prev_hp = GameManager.player2_hp
			hp.text = "HP: " + str(prev_hp) 
		if GameManager.player2_actions != prev_actions:
			prev_actions = GameManager.player2_actions
			actions.text = "Actions: " + str(prev_actions) 
