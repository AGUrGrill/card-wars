extends HBoxContainer

const CARD = preload("uid://bdhwi5f8rf0td")
var hand_size = 0

func _process(delta: float) -> void:
	if hand_size != GameManager.player1_hand.size():
		display_hand()
		hand_size = GameManager.player1_hand.size()

func display_hand():
	# Remove old
	for child in get_children():
		remove_child(child)
	
	# Add new
	var space = 0
	for card in GameManager.player1_hand:
		if card == null:
			continue
		var img_url = card["ImageURL"]
		if img_url != null:
			var new_card = CARD.instantiate()
			add_child(new_card)
			new_card.position.x += space
			space += 120
			new_card.url_update_card(img_url)
		
