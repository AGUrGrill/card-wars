extends HBoxContainer

@export var PLAYER_NUM = 1

const CARD = preload("uid://bdhwi5f8rf0td")
var hand_size = 0

func _process(delta: float) -> void:
	# Display hand on new hand size
	if PLAYER_NUM == 1:
		if hand_size != GameManager.player1_hand.size():
			hand_size = GameManager.player1_hand.size()
			display_hand()
	elif PLAYER_NUM == 2:
		if hand_size != GameManager.player2_hand.size():
			hand_size = GameManager.player2_hand.size()
			display_hand()

# Calculate spacing and display hand
func display_hand():
	# Remove old
	for child in get_children():
		remove_child(child)
	
	# Add cards to deck
	var i = 1
	var calculated_space
	if PLAYER_NUM == 1:
		for card in GameManager.player1_hand:
			calculated_space = size.x / GameManager.player1_hand.size()
			if card == null:
				continue
			add_cards_to_hand(card, i, calculated_space)
			i += 1
	elif PLAYER_NUM == 2:
		for card in GameManager.player2_hand:
			calculated_space = size.x / GameManager.player2_hand.size()
			if card == null:
				continue
			add_cards_to_hand(card, i, calculated_space)
			i += 1

# Add cards to hand accordingly
func add_cards_to_hand(card: Dictionary, num: int, calculated_space: float):
	var img_url = card["ImageURL"]
	if img_url != null:
		var new_card = CARD.instantiate()
		add_child(new_card)
		new_card.position.x += calculated_space * num
		new_card.position.y += size.y / 2
		new_card.url_update_card(img_url)
		update_card_info(new_card, card)

# Updates card info based on if creature or other
func update_card_info(new_card: Area2D, card: Dictionary):
	print(card["Name"])
	if card["Name"] == "Unknown":
		return
	if card["Card Type"] == "Teamwork" or card["Card Type"] == "Hero":
		return
	
	if card["Card Type"] != "Creature":
		new_card.set_card_info(
			card["Name"],
			card["Card Type"],
			int(card["Cost"]),
			0,
			0,
			card["Ability"],
			card["Landscape"],
		)
	else:
		new_card.set_card_info(
			card["Name"],
			card["Card Type"],
			int(card["Cost"]),
			int(card["Attack"]),
			int(card["Defense"]),
			card["Ability"],
			card["Landscape"],
		)
