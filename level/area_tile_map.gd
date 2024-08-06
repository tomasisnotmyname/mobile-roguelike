extends TileMapLayer

@export var starting_area := false
@export_range(0.0, 1.0) var probability := 1.0
@onready var map_size = get_used_rect().size
var tile_map: Array

func _ready():
	var tile_data
	for column in map_size.x:
		tile_map.append([])
		for row in map_size.y:
			tile_data = get_cell_tile_data(Vector2i(column,row))
			if not tile_data:
				tile_map[column].append('none')
			else:
				tile_map[column].append(tile_data.get_custom_data('Type'))

func get_area() -> Dictionary:
	var area: Dictionary
	area.name = name
	area.starting_area = starting_area
	area.probability = probability
	area.map_size = map_size
	area.tile_map = tile_map
	return area
