extends Node

@export var level_to_generate: Level

func _ready() -> void:
	$LevelMap.generate_level_map(level_to_generate)
