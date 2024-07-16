extends TileMap



@export var update_tile_set : bool = false
@export_group('Updated Properties')
@export_range(0.0, 1.0) var base_tile_darkness : float = 0.0
@export_range(0.0, 1.0) var background_darkness : float = 0.0
@export_range(0.0, 1.0) var border_darkness : float = 0.0

var tiles_setup : Dictionary = {
	'Base Tile' : Callable(self, 'base_tile_setup'),
	'Background Alternative' : Callable(self, 'background_tile_setup'),
	'Border Alternative' : Callable(self, 'border_tile_setup')
}

var square_polygon := PackedVector2Array([Vector2(-32,-32), Vector2(32,-32), Vector2(32,32), Vector2(-32,32)])

var tile_set_source : TileSetAtlasSource
var base_tile_id : Vector2i


func base_tile_setup(tile : TileData):
	tile.set_collision_polygons_count(0, 0)
	tile.add_collision_polygon(0)
	tile.set_collision_polygon_points(0, 0, square_polygon)
	tile.modulate = tile.modulate.darkened(base_tile_darkness)

func background_tile_setup(tile : TileData):
	tile.set_custom_data('Name', 'Background')
	tile.set_collision_polygons_count(0, 0)

	var base_tile = tile_set_source.get_tile_data(base_tile_id, 0)
	if base_tile.modulate.r != base_tile.modulate.g:
		tile.modulate = base_tile.modulate
	tile.modulate = tile.modulate.darkened(background_darkness)


func border_tile_setup(tile : TileData):
	tile.set_custom_data('Name', 'Border')
	tile.set_collision_polygons_count(0, 0)
	tile.add_collision_polygon(0)
	tile.set_collision_polygon_points(0, 0, square_polygon)

	var base_tile = tile_set_source.get_tile_data(base_tile_id, 0)
	if base_tile.modulate.r != base_tile.modulate.g:
		tile.modulate = base_tile.modulate
	tile.modulate = tile.modulate.darkened(border_darkness)


func _ready():
	if update_tile_set:
		var setup_keys : Array = tiles_setup.keys()

		for source_index in range(tile_set.get_source_count()):
			tile_set_source = tile_set.get_source(tile_set.get_source_id(source_index))

			for tile_index in range(tile_set_source.get_tiles_count()):
				base_tile_id = tile_set_source.get_tile_id(tile_index)
		
				for alternative_index in range(tile_set_source.get_alternative_tiles_count(base_tile_id)):
					if alternative_index > 0:
						tile_set_source.remove_alternative_tile(base_tile_id, alternative_index)

				for alternative_index in range(3):
					if not tile_set_source.has_alternative_tile(base_tile_id, alternative_index):
						tile_set_source.create_alternative_tile(base_tile_id, alternative_index)
					tiles_setup[setup_keys[alternative_index]].call(tile_set_source.get_tile_data(base_tile_id, alternative_index))

		print(ResourceSaver.save(tile_set))
		update_internals()
