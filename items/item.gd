extends RigidBody2D
class_name Item

@onready var sprite = $Sprite2D.get_texture()

func use(target):
	print('item_used')

func equip():
	position = Vector2(13,10)
	rotation_degrees = 45
