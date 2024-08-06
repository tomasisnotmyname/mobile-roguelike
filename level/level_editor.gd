# set file name in the LevelEditor inspector
# set area shape size and other properties on ShapeCast2Ds in AreaCasts


extends Control

@export var file_name := 'new_level.tres'
@export var area_tile_map_scene: PackedScene
#var area_tile_map_scene = preload()
var type_atlas_coords: Dictionary



func _ready() -> void:
	if not '.tres' in file_name:
		file_name += '.tres'

	var tile_map = area_tile_map_scene.instantiate()
	var tile_source = tile_map.tile_set.get_source(0)
	tile_map.queue_free()
	var tile_data = TileData
	var tile_type: String

	for tile_index in tile_source.get_atlas_grid_size().y:
		tile_data = tile_source.get_tile_data(Vector2i(0,tile_index),0)
		tile_type = tile_data.get_custom_data('Type')
		if tile_type:
			type_atlas_coords[tile_type] = Vector2i(0,tile_index)

	$FileNameEdit.show()
	$SaveButton.show()
	$LoadButton.show()
	$ClearButton.show()



func _on_line_edit_text_changed(new_text: String) -> void:
	file_name = new_text



func _on_save_button_pressed() -> void:
	var areas : Array[Dictionary]

	for tile_map in $AreaTileMaps.get_children():
		areas.append(tile_map.get_area())

	var new_resource = Level.new()
	new_resource.take_over_path('res://level/levels/' + file_name)
	new_resource.set_properties(areas)
	print(ResourceSaver.save(new_resource))
	print(new_resource.resource_path)



func _on_load_button_pressed() -> void:
	var loaded_level: Level = load("res://level/levels/" + file_name)
	var paste_position := Vector2i.ZERO
	var tile_type: String

	for area in loaded_level.areas:
		var area_tile_map =  area_tile_map_scene.instantiate()
		$AreaTileMaps.add_child(area_tile_map)
		area_tile_map.position = paste_position
		paste_position.x += area.map_size.x * 64 + 64

		for column in area.map_size.x:
			for row in area.map_size.y:
				tile_type = area.tile_map[column][row]
				if tile_type != 'none':
					area_tile_map.set_cell(Vector2i(column, row), 0, type_atlas_coords[tile_type])



func _on_clear_button_pressed() -> void:
	for child in $AreaTileMaps.get_children():
		child.queue_free()
