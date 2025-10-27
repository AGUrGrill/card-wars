extends Area2D

const BLUE_PLAINS = preload("uid://bmenhhrlrgex1")
const CORNFIELD = preload("uid://dy0nyfhbx6kg1")
const ICY_LANDS = preload("uid://b6t8lrpxj6lsc")
const NICE_LANDS = preload("uid://bopxtr8tjtx2s")
const SANDY_LANDS = preload("uid://fk84vutlv3ll")
const USELESS_SWAMP = preload("uid://dnqa061huodog")

@onready var sprite_2d: Sprite2D = $Sprite2D

func change_landscape_type(landscape: String):
	match landscape:
		"Cornfield": sprite_2d.texture = CORNFIELD
		"Blue Plains": sprite_2d.texture = BLUE_PLAINS
		"Icy Lands": sprite_2d.texture = ICY_LANDS
		"Nice Lands": sprite_2d.texture = NICE_LANDS
		"Sandy Lands": sprite_2d.texture = SANDY_LANDS
		"Useless Swamp": sprite_2d.texture = USELESS_SWAMP

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_pressed():
		print("Selected ", self.name)
		if GameManager.selected_card != null:
			var card = GameManager.selected_card
			card.get_parent().remove_child(card)
			get_parent().add_child(card)
			card.set_owner(get_parent())
			card.position = position
			GameManager.unselect_card(card.get_instance_id())
			print("Moved card to ", self.name)
