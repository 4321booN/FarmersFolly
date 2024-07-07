extends Node


func _input(event) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_P:
			Save.savegame()
