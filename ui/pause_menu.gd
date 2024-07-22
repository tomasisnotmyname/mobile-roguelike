extends Control


func _ready():
	_hide()


func _hide():
	hide()
	$MoveUIControl._hide()


func _on_resume_button_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_move_ui_button_pressed() -> void:
	$MoveUIControl._show()
	$MenuPanel.hide()


func _on_done_button_pressed() -> void:
	$MoveUIControl._hide()
	$MenuPanel.show()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
