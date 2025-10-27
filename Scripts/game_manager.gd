extends Node

var selected_card = null
var card_already_selected = false
const MAX_CARDS = 568 # 717 is newest, 568 is released
const CARD_LIST = "res://Assets//card_list.json"

var curr_turn = 0
var prev_turn = curr_turn

# Player vars
var player1_hand = []
var player2_hand = []

const BASE_HP = 25
var player1_hp = BASE_HP
var player2_hp = BASE_HP

const BASE_ACTIONS = 2
var player1_actions = BASE_ACTIONS
var player2_actions = BASE_ACTIONS

func _ready() -> void:
	player1_hand = draw_starting_hand()
	player2_hand = draw_starting_hand()
	
	print(player1_hand)
	print(player2_hand)

# Selects card and applies effect
func select_card(card_id: int):
	if !card_already_selected:
		selected_card = instance_from_id(card_id)
		selected_card.modulate = Color(0.775, 0.775, 0.775, 1.0)
		card_already_selected = true
	else:
		unselect_card(card_id)
		select_card(card_id)

# Unselects card
func unselect_card(card_id: int):
	selected_card.modulate = Color(1.0, 1.0, 1.0, 1.0)
	selected_card = null
	card_already_selected = false

# Remove card from player hand
func remove_card(player_num: int, card: Object):
	var i = 0
	if player_num == 1:
		for curr_card in player1_hand:
			if curr_card["Name"] == card.card_name:
				change_actions(player_num, card.cost)
				player1_hand.pop_at(i)
				continue
			i += 1
	elif player_num == 2:
		for curr_card in player2_hand:
			if curr_card["Name"] == card.card_name:
				change_actions(player_num, card.cost)
				player2_hand.pop_at(i)
				continue
			i += 1

# Load card list
func load_json_file(file_path: String) -> Dictionary:
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var json_text = file.get_as_text()
		file.close()
		
		var json = JSON.new()
		var json_data = json.parse(json_text)
		return json.data
	else:
		print("File does not exist.")
	return {}

# Draw starting hands
func draw_starting_hand():
	var temp_hand = []
	while temp_hand.size() < 5:
		temp_hand.push_back(draw_card())
	
	return temp_hand

# Draw card
func draw_card():
	var json_data = GameManager.load_json_file(GameManager.CARD_LIST)
	if !json_data:
		return
	
	var temp_card
	var card_not_found = true
	while card_not_found:
		var card_data = json_data[str(randi() % MAX_CARDS)]
		if card_data["Name"] == "Unknown":
			continue
		if card_data["Card Type"] != "Landscape" and card_data["Card Type"] != "Hero" and card_data["Card Type"] != "Teamwork":
			temp_card = card_data
			card_not_found = false
	
	return temp_card

# Add or remove player health
func change_HP(player_num: int, num: int):
	if player_num == 1:
		player1_hp -= num
	if player_num == 2:
		player2_hp -= num

# Add or remove player actions
func change_actions(player_num: int, num: int):
	if player_num == 1 and (player1_actions - num) >= 0:
		player1_actions -= num
	if player_num == 2 and (player2_actions - num) >= 0:
		player2_actions -= num
