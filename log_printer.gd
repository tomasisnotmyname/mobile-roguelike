extends Node

var recently_logged_events : Array

func _print(event : String, event_source := '', event_time := 0.0, delay:= 0):
	event_time = event_time / 1000
	var event_id = [event_source, event]

	if event_id not in recently_logged_events:
		if event_time:
			print(event_time, ':', event_source)
		elif event_source:
			print(event_source)
		print(event)
		print()

	if delay:
		recently_logged_events.append(event_id)
		await get_tree().create_timer(delay).timeout
		recently_logged_events.erase(event_id)
