extends CharacterBody2D

@export_range(0.0, 1000.0) var speed : float = 300.0
@export_range(-1000.0, 0.0) var jump_velocity : float = -400.0
@export_range(0.0, 1960.0) var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var eyes_node : Node2D = $FlippingParts/Eyes

var equipped_item: Item
var second_item: Item

var facing_direction: Vector2
var vertical_directions : Dictionary = {-1: -15, 0: 0, 1: 15}

signal can_interact_with_item(item: Item)
signal cant_interact_with_item(item: Item)
signal swapped_equipped_item(item: Item)



func pick_up(item: Item):
	$InteractableArea.monitoring = false

	item.process_mode = PROCESS_MODE_DISABLED
	get_parent().remove_child(item)

	if second_item:
		drop_equipped_item()
		equip(item)
	elif equipped_item:
		second_item = item
		swap()
	else:
		equip(item)

	$InteractableArea.monitoring = true


func equip(item):
	$FlippingParts.add_child(item)
	equipped_item = item
	equipped_item.equip()
	


func unequip(item):
	$FlippingParts.remove_child(item)
	second_item = item


func swap():
	var to_second = equipped_item
	var to_equipped = second_item
	equip(to_equipped)
	unequip(to_second)
	swapped_equipped_item.emit(equipped_item)


func drop_equipped_item():
	$FlippingParts.remove_child(equipped_item)
	get_parent().add_child(equipped_item)
	equipped_item.position = get_parent().to_local(to_global(Vector2.ZERO))
	equipped_item.process_mode = PROCESS_MODE_INHERIT



func use():
	if equipped_item:
		equipped_item.use()


func face(direction : Vector2i):
	if direction.x != 0:
		facing_direction.x = direction.x
		$FlippingParts.scale.x = direction.x

	if direction.y != facing_direction.y:
		eyes_node.rotation_degrees = vertical_directions[direction.y]
		facing_direction.y = direction.y

	if equipped_item:
		equipped_item.point(direction)



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

	if direction != facing_direction:
		face(direction)
	move_and_slide()



func _on_interactable_area_item_entered(item: Item) -> void:
	can_interact_with_item.emit(item)


func _on_interactable_area_body_exited(item: Item) -> void:
	cant_interact_with_item.emit(item)
