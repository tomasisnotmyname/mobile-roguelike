extends TileMap

@export var generate_map_on_ready := false

func _ready():
	$ExtraBackground.show()
	if generate_map_on_ready:
		generate_map()

func break_block(block_rid: RID):
	var coords: Vector2i = get_coords_for_body_rid(block_rid)
	if get_cell_tile_data(1, coords).get_custom_data('breakable'):
		erase_cell(1, coords)

func generate_map(level: String = 'default'):
	pass
