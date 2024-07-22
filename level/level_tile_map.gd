extends TileMap

func _ready():
	$ExtraBackground.show()

func break_block(block_rid: RID):
	var coords: Vector2i = get_coords_for_body_rid(block_rid)
	var block: TileData = get_cell_tile_data(1, coords)
	if block and block.get_custom_data('breakable'):
		erase_cell(1, coords)
