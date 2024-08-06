#Change list:
# Added a Cooldown node and script to all items.
# Made Pickaxe and Drill function differently but both usefully.
# User can hold ActionButton for continuous uninterrupted item usage.
#
# Made a Level resource that can be assigned and properties needed for level generation.
# Made a LevelEditor scene capable of saving level resources containing all rooms in the level and all required and given properties.
# Made an AreaTileMap scene that is used in the LevelEditor for creating and adding properties to all areas possible in a level.
# Made a second LevelMap scene (unused yet) that randomly generates levels using Level resource and a second Main scene (unused yet) that runs it.
#
# Added few prints for ArrowButtons debugging.

#Current plans:
# Fix ArrowPad and ArrowButtons.
#
# Create unbreakable borders when generating map.
# Draw background that matches foreground.
# Replace Main and LevelMap scenes.
# Write script for player and item spawning in Level generation.
# Add item and player spawn location setter in LevelEditor (through additional TileMapLayer?).
#
# Add connnection properties to areas for more seamless level generation.
# Add more random areas for more varied generation.
# Figure out how to make possible tiles and possible tile groups.
#
# Figure out how to use terrains.


#Bugs:
# Buttons on the ArrowPad fucking disappear.
#
# (Not relevant for mobile experience) 
# When changing movement direction with ArrowPad without releasing the mouse button, the direction is stuck until mouse exits.

#Ideas:
# No down left and down right buttons on ArrowPad.
#
# Experiment with PlayerCharacter script by trying to modify sideways movement with delta too?
#
# Bottom collision of PlayerCharacter gets wider when they run and thinner when they stand still.
# Player can't change direction when in air / horizontal velocity is slower in air.
# Lower/higher PlayerCharacter.
#
# Sort GUI children into GameplayUI and MenuUI
#
# Add drop item button.



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
