extends Control


func _ready():
	var click_mask = BitMap.new()
	click_mask.create_from_image_alpha($UpButton.texture_normal.get_image())
	$UpButton.set_click_mask(click_mask)
	click_mask.create_from_image_alpha($DownButton.texture_normal.get_image())
	$DownButton.set_click_mask(click_mask)
	click_mask.create_from_image_alpha($LeftButton.texture_normal.get_image())
	$LeftButton.set_click_mask(click_mask)
	click_mask.create_from_image_alpha($RightButton.texture_normal.get_image())
	$RightButton.set_click_mask(click_mask)



func _on_up_button_button_down():
	Input.action_press('up')

func _on_down_button_button_down():
	Input.action_press('down')

func _on_left_button_button_down():
	Input.action_press('left')

func _on_right_button_button_down():
	Input.action_press('right')



func _on_up_button_button_up():
	Input.action_release('up')

func _on_down_button_button_up():
	Input.action_release('down')

func _on_left_button_button_up():
	Input.action_release('left')

func _on_right_button_button_up():
	Input.action_release('right')
