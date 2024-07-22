extends RigidBody2D
class_name Item

@onready var sprite = $Sprite2D.get_texture()

func use():
	pass

func equip():
	position = Vector2(13,10)
	rotation_degrees = 45

func point(_towards: Vector2):
	pass
