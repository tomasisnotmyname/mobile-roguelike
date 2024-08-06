extends Node2D

var type_coords: Dictionary
var chunk_map = [
	[0,0,0,0,0],
	[0,0,0,0,0],
	[0,0,0,0,0],
	[0,0,0,0,0],
	[0,0,0,0,0]
]



func _ready():
	var tile_source = $Foreground.tile_set.get_source(0)
	var atlas_grid_size = tile_source.get_atlas_grid_size()
	var atlas_coords := Vector2i.ZERO
	var alternative_id: int
	var tile_data = TileData
	var tile_type: String


	for index_x in atlas_grid_size.x:
		atlas_coords.x = index_x
		for index_y in atlas_grid_size.y:
			atlas_coords.y = index_y
			for alternative_index in tile_source.get_alternative_tiles_count(atlas_coords):
				alternative_id = tile_source.get_alternative_tile_id(atlas_coords, alternative_index)
				tile_data = tile_source.get_tile_data(atlas_coords,alternative_id)
				tile_type = tile_data.get_custom_data('Type')
				if tile_type:
					if not tile_type in type_coords:
						type_coords[tile_type] = []
					for i in range(tile_data.probability*100):
						type_coords[tile_type].append([atlas_coords, alternative_id])



func generate_level_map(level: Level):
	var rng = RandomNumberGenerator.new()

	var area_pool: Array
	for area in level.areas:
		if area.starting_area:
			place_area_at(area, Vector2i(rng.randi_range(0, 4), 0))
		else:
			for i in range(area.probability*100):
				area_pool.append(area)

	var map_is_full := false
	while map_is_full != true:
		if not map_is_full:
			map_is_full = true
			for row_index in range(chunk_map.size()):
				for column_index in range(chunk_map[row_index].size()):
					if not chunk_map[row_index][column_index]:
						map_is_full = false
						while true:
							var placed_area = area_pool[rng.randi_range(0, area_pool.size()-1)]
							if place_area_at(placed_area, Vector2i(column_index, row_index)) == 'success':
								break



func place_area_at(area: Dictionary, at: Vector2i) -> String:
	var rng = RandomNumberGenerator.new()

	var area_chunk_size = area.map_size / 4
	var chunk_x: int
	var chunk_y: int
	for index_x in range(area_chunk_size.x):
		chunk_x = index_x + at.x
		for index_y in range(area_chunk_size.y):
			chunk_y = index_y + at.y
			if chunk_x > 4 or chunk_y > 4 or chunk_map[chunk_y][chunk_x]:
				return 'oopsie'

	for index_x in area_chunk_size.x:
		for index_y in area_chunk_size.y:
			chunk_map[index_y + at.y][index_x + at.x] = 1


	at = at * 4
	var tile_type: String
	for column in area.map_size.x:
		for row in area.map_size.y:
			tile_type = area.tile_map[column][row]
			if tile_type != 'none':
				var tile_pool = type_coords[tile_type]
				var placed_tile = tile_pool[rng.randi_range(0, tile_pool.size()-1)]
				$Foreground.set_cell(Vector2i(column + at.x, row + at.y), 0, placed_tile[0], placed_tile[1])

	return 'success'
