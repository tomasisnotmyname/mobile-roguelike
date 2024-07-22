extends Button


func _ready() -> void:
	hide()


func _on_player_character_swapped_equipped_item(item: Item) -> void:
	icon = item.sprite
	show()


func _on_pressed() -> void:
	%PlayerCharacter.swap()
