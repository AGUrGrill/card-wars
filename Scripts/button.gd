extends Button

const CARD = preload("uid://bdhwi5f8rf0td")

func _on_pressed() -> void:
	GameManager.player1_hand.push_back(GameManager.draw_card())
