extends HBoxContainer

const CARD = preload("uid://bdhwi5f8rf0td")
var hand_size = 0

func _process(delta: float) -> void:
	# Display hand on new hand size
	if hand_size != GameManager.player1_hand.size():
		display_hand()
		hand_size = GameManager.player1_hand.size()

# Calculate spacing and display hand
func display_hand():
	# Remove old
	for child in get_children():
		remove_child(child)
	
	# Add new
	var calculated_space = size.x / GameManager.player1_hand.size()
	var i = 0
	for card in GameManager.player1_hand:
		if card == null:
			continue
		var img_url = card["ImageURL"]
		if img_url != null:
			var new_card = CARD.instantiate()
			add_child(new_card)
			new_card.position.x = calculated_space * i
			new_card.url_update_card(img_url)
			update_card_info(new_card, card)
		i += 1

# Updates card info based on if creature or other
func update_card_info(new_card: Area2D, card: Dictionary):
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
