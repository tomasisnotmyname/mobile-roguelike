extends RigidBody2D
class_name Item

@onready var sprite = $Sprite2D.get_texture()
var can_be_used := true

func use():
	if can_be_used:
		start_cooldown()

func start_cooldown():
	can_be_used = false
	$Cooldown.start()

func _on_cooldown_completed() -> void:
	can_be_used = true

func equip():
	position = Vector2(13,10)
	rotation_degrees = 45

func point(_towards: Vector2):
	pass
