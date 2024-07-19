extends Control

@export var arrow_pad : Control
var moving_arrow_pad := false
var moving_offset : Vector2



func _show():
	show()
	$DoneButton.disabled = false
	set_process_input(true)

func _hide():
	hide()
	$DoneButton.disabled = true
	set_process_input(false)



func _input(event: InputEvent) -> void:
	if moving_arrow_pad:
		if event.is_action_released('left_mouse_button'):
			moving_arrow_pad = false
			arrow_pad.position = event.position + moving_offset
			return
		elif event is InputEventMouseMotion:
			arrow_pad.position = event.position + moving_offset
	elif event.is_action_pressed('left_mouse_button') and arrow_pad.get_global_rect().has_point(event.position):
		moving_offset = arrow_pad.position - event.position
		moving_arrow_pad = true
