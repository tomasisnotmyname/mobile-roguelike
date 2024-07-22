extends Item

func use():
	if $RayCast2D.is_colliding():
		$RayCast2D.get_collider().break_block($RayCast2D.get_collider_rid())

func equip():
	position = Vector2(17,18)
	rotation_degrees = 90
