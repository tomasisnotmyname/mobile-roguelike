extends Control

@export var movable_UI_nodes: Array[Control]
var moving_node: Control
var moving_offset : Vector2


func _show():
	show()
	$DoneButton.disabled = false
	for node in movable_UI_nodes:
		if node is Button:
			node.disabled = true
	set_process_input(true)

func _hide():
	hide()
	$DoneButton.disabled = true
	for node in movable_UI_nodes:
		if node is Button:
			node.disabled = false
	set_process_input(false)


func _input(event: InputEvent) -> void:
	if moving_node:
		if event.is_action_released('left_mouse_button'):
			moving_node.position = event.position + moving_offset
			moving_node = null
			return
		elif event is InputEventMouseMotion:
			moving_node.position = event.position + moving_offset

	elif event.is_action_pressed('left_mouse_button'):
		for movable_node in movable_UI_nodes:
			if movable_node.get_global_rect().has_point(event.position):
				moving_node = movable_node
				moving_offset = moving_node.position - event.position
				break
