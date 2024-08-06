extends ProgressBar

signal completed

func _ready():
	hide()

func start():
	value = 0
	set_process(true)
	show()

func _process(_delta: float) -> void:
	if value < max_value:
		value += step
	else:
		completed.emit()
		hide()
		set_process(false)
		
