extends TextureButton

var input_actions : PackedStringArray


func _ready():
	print(name)
	print('position:',position)
	print('z_index:',z_index)
	print('visible:',visible)
	print()
	input_actions = name.replace('Button','').to_snake_case().split('_')
	
	var click_mask = BitMap.new()
	click_mask.create_from_image_alpha(texture_normal.get_image())
	set_click_mask(click_mask)

	pressed.connect(_on_pressed)
	button_up.connect(_on_released)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


func _on_pressed():
	if Input.is_action_pressed('left_mouse_button'):
		for action in input_actions:
			Input.action_press(action)

func _on_released():
	for action in input_actions:
		Input.action_release(action)

func _on_mouse_entered():
	_on_pressed()

func _on_mouse_exited():
	_on_released()
