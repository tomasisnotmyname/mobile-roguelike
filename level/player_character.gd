extends CharacterBody2D

@export_range(0.0, 1000.0) var speed : float = 300.0
@export_range(-1000.0, 0.0) var jump_velocity : float = -400.0
@export_range(0.0, 1960.0) var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var interactable_area : Area2D

var equipped_item: Item
var second_item: Item

signal can_interact_with_item(item: Item)
signal cant_interact_with_item(item: Item)
signal swapped_equipped_item(item: Item)

const LEFT : int = -1
const RIGHT : int = 1



func pick_up(item: Item):
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


var bruh_amplifier = 0
var bruh_pitcher = 0
func use():
	if equipped_item:
		equipped_item.use('peepee')
	else:
		var bruh_audio_player = AudioStreamPlayer.new()
		add_child(bruh_audio_player)
		bruh_audio_player.stream = load('res://screamer.mp3')
		bruh_audio_player.volume_db += bruh_amplifier
		bruh_audio_player.pitch_scale -= bruh_pitcher
		bruh_amplifier += 10
		bruh_pitcher += 0.05
		bruh_audio_player.play()
		await bruh_audio_player.finished
		bruh_audio_player.queue_free()


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



func _on_interactable_area_item_entered(item: Item) -> void:
	can_interact_with_item.emit(item)

func _on_interactable_area_body_exited(item: Item) -> void:
	cant_interact_with_item.emit(item)
