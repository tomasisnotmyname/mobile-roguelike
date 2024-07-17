#current plans:
# tools
# give character one or two slots for items
# make a pickaxe
# interacting with blocks while holding pickaxe breaks them
# borders are unbreakable
# jumping or moving down makes character face up or down respectively
# interactable area moves along with the facing direction

#notes
# maybe no down left and down right buttons


extends Node

@onready var root : Window = get_tree().root

@export var player_camera : Camera2D
var camera_limited := true

const MAX_PORTRAIT_RATIO := 0.5625
const MAX_LANDSCAPE_RATIO := 1.7777



func _ready():
	root.size_changed.connect(check_aspect_ratio)
	check_aspect_ratio()


func check_aspect_ratio():
	var aspect_ratio := float(root.size.x) / float(root.size.y)

	if camera_limited:
		if aspect_ratio > MAX_LANDSCAPE_RATIO or aspect_ratio < MAX_PORTRAIT_RATIO:
			player_camera.limit_left = -10000000
			player_camera.limit_top = -10000000
			player_camera.limit_right = 10000000
			player_camera.limit_bottom = 10000000
			camera_limited = false

	elif aspect_ratio < MAX_LANDSCAPE_RATIO and aspect_ratio > MAX_PORTRAIT_RATIO:
		player_camera.limit_left = 0
		player_camera.limit_top = 0
		player_camera.limit_right = 1280
		player_camera.limit_bottom = 1280
		camera_limited = true
