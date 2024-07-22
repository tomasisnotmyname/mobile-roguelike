extends CanvasLayer


func _ready():
	show()
	get_tree().paused = false


func _on_pause_button_pressed() -> void:
	if $PauseMenu.visible:
		get_tree().paused = false
		$PauseMenu._hide()
	else:
		get_tree().paused = true
		$PauseMenu.show()
		#move_child($PauseMenu, $InfoMenu.get_index+1)


func _on_action_button_pressed() -> void:
	%PlayerCharacter.use()
