extends Item

var pointing_directions := {
	'[-1, false]': -90, '[-1, true]': -45,
	'[1, false]': 90, '[1, true]': 45
	}

func _ready():
	$Cooldown.max_value = 50

func use():
	if $RayCast2D.is_colliding() and can_be_used:
		$RayCast2D.get_collider().break_block($RayCast2D.get_collider_rid())
		start_cooldown()

func equip():
	position = Vector2(17,1)
	rotation_degrees = 40

func point(towards: Vector2):
	if towards.y != 0:
		$RayCast2D.rotation_degrees = pointing_directions[str([towards.y, towards.x != 0])]
	else:
		$RayCast2D.rotation_degrees = 0
