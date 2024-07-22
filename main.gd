#Change list:
# Revised and retextured the LevelTileMap and its TileSet.
# Added functionality to items.
# Fixed pick up button.
# Fixed pause button.

#Current plans:
# Drill breaks blocks faster and only horizontally.
# Add a cooldown bar item usage / an action bar that shows when block will break based on their durability.
#
# Figure out how to use terrains.
# Write script that procedurally generates levels using patterns as chunks and given parameters.
# Parameters:
# The level size to determine borders and how many chunks it needs.
# Required rooms (chunks) for player starting area, level exit, and any additional special locations.
# Depth for determining the block properties as well as background colors and such.


#Bugs:
# (Not relevant for mobile experience) 
# When changing movement direction with ArrowPad without releasing the mouse button, the direction is stuck until mouse exits.

#Ideas:
# No down left and down right buttons on ArrowPad.
#
# Bottom collision of PlayerCharacter gets wider when they run and thinner when they stand still.
# Player can't change direction when in air / horizontal velocity is slower in air.
#
# Lower PlayerCharacter.
#
# Sort GUI children into GameplayUI and MenuUI
#
# Add drop button.



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
