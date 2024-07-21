extends Button

var items: Array



func _ready():
	hide()


func _show(_text: String):
	show()
	set_process_input(true)
	text = _text

func _hide():
	hide()
	set_process_input(false)



func _on_player_character_can_interact_with_item(item: Item) -> void:
	items.append(item)
	_show('Pick-Up')

func _on_player_character_cant_interact_with_item(item: Item) -> void:
	items.erase(item)
	if items.size() == 0:
		_hide()



func _on_pressed() -> void:
	if items.size() == 1:
		%PlayerCharacter.pick_up(items[0])
	else:
		pass
