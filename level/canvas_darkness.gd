# Darkens all things drawn on Level canvas.

extends CanvasModulate

# If false, Level won't be darkened.
@export var enabled : bool = true

func _ready():
	if enabled:
		show()
	else:
		hide()
