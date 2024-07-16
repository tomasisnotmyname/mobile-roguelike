# learn more about lightning and shadows
# https://www.gdquest.com/tutorial/godot/2d/limiting-vision-with-lights/
#
# tools
# give character one or two slots for items
# make a pickaxe
# interacting with blocks while holding pickaxe breaks them
# borders are unbreakable
# jumping or moving down makes character face up or down respectively
# interactable area moves along with the facing direction


extends Node

func _ready():
	$CanvasModulate.show()
