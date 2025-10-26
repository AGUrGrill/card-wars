extends Node2D

@onready var http_request: HTTPRequest = $HTTPRequest
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var damage_label: Label = $DamageLabel
var card_type = "Creature"

# Update card based on index
func idx_update_card(idx: int):
	var json_data = GameManager.load_json_file(GameManager.CARD_LIST)
	if json_data:
		var card_data = json_data[str(idx)]
		if card_data["Card Type"] == card_type:
			http_request.request(card_data["ImageURL"])

# Update card based on image
func url_update_card(image_url: String):
	if image_url != null:
		http_request.request(image_url)

# When image request complete
func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var image = Image.new()
	var get_img = image.load_png_from_buffer(body)
	if get_img != OK:
		get_img = image.load_jpg_from_buffer(body)
		image.resize(image.get_width() * 2, image.get_height() * 2, Image.INTERPOLATE_LANCZOS)
	if get_img != OK:
		image.resize(image.get_width() / 2, image.get_height() / 2, Image.INTERPOLATE_LANCZOS)
		get_img = image.load_webp_from_buffer(body)
	
	var texture = ImageTexture.create_from_image(image)
	sprite_2d.texture = texture

# Check when selected
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		GameManager.selected_node = self
		print("Selected card: " + self.name)

# Reduce dmg token
func _on_defense_minus_pressed() -> void:
	damage_label.text = str(int(damage_label.text) - 1)

# Add to dmg token
func _on_defense_plus_pressed() -> void:
	damage_label.text = str(int(damage_label.text) + 1)
