extends TextureButton

var input_actions : PackedStringArray


func _ready():
	input_actions = name.replace('Button','').to_snake_case().split('_')
	
	var click_mask = BitMap.new()
	click_mask.create_from_image_alpha(texture_normal.get_image())
	set_click_mask(click_mask)

	pressed.connect(_on_pressed)
	mouse_entered.connect(_on_pressed)
	button_up.connect(_on_released)
	mouse_exited.connect(_on_released)


func _on_pressed():
	if Input.is_action_pressed('left_mouse_button'):
		for action in input_actions:
			Input.action_press(action)

func _on_released():
	for action in input_actions:
		Input.action_release(action)
