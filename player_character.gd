extends CharacterBody2D

@export_range(0.0, 1000.0) var speed : float = 300.0
@export_range(-1000.0, 0.0) var jump_velocity : float = -350.0
@export_range(0.0, 1960.0) var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var interactable_area : Area2D

const LEFT : int = -1
const RIGHT : int = 1


func face(direction : int):
	$FlippingParts.scale.x = direction


func _physics_process(delta):
	var direction := Vector2.ZERO

	# Handles jumping, and in the future dropping.
	direction.y = Input.get_axis('up', 'down')
	if is_on_floor() and direction.y < 0:
		velocity.y = jump_velocity
	elif not is_on_floor():
		velocity.y += gravity * delta

	# Handles moving left and right, as well as slowing down or stopping immediately when hitting walls.
	direction.x = Input.get_axis('left', 'right')
	if direction.x:
		velocity.x = move_toward(velocity.x, direction.x * speed, speed/10)
	elif is_on_wall():
		velocity.x = 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed/10)

	if velocity:
		if velocity.x > 0:
			face(RIGHT)
		elif velocity.x < 0:
			face(LEFT)

		move_and_slide()
