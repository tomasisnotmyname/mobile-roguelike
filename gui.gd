extends CanvasLayer

var paused : bool


func _ready():
	$MoveUIControl._hide()
	unpause()



func pause():
	get_tree().paused = true
	paused = true
	$PauseMenu.show()

func unpause():
	get_tree().paused = false
	paused = false
	$PauseMenu.hide()



func _on_pause_button_pressed() -> void:
	if paused:
		unpause()
	else:
		pause()

func _on_resume_button_pressed() -> void:
	unpause()

func _on_exit_button_pressed() -> void:
	get_tree().quit()



func _on_move_ui_button_pressed() -> void:
	$MoveUIControl._show()
	$PauseMenu.hide()
	$PauseMenu.set_process_input(false)

func _on_done_button_pressed() -> void:
	$MoveUIControl._hide()
	$PauseMenu.show()
	$PauseMenu.set_process_input(true)
