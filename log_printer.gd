extends Node

var recently_logged_events : Array

func _print(event_time : float, event_source : String, event : String):
	event_time = event_time / 1000
	var event_id = [event_source, event]

	if event_id not in recently_logged_events:
		print(event_time, ':', event_source)
		print(event)
		print()

		recently_logged_events.append(event_id)
		await get_tree().create_timer(0.5).timeout
		recently_logged_events.erase(event_id)
