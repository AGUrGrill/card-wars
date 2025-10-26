extends Node

var selected_node
const MAX_CARDS = 568 # 717 is newest, 568 is released
const CARD_LIST = "res://card_list.json"

var player1_hand = []
var player2_hand = []

func _ready() -> void:
	player1_hand = draw_starting_hand()
	player2_hand = draw_starting_hand()
	
	print(player1_hand)
	print(player2_hand)

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
		if card_data["Card Type"] != "Landscape" and card_data["Card Type"] != "Hero" and card_data["Card Type"] != "Teamwork":
			temp_card = card_data
			card_not_found = false
	
	return temp_card
