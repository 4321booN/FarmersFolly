extends Control

const world_area: String = "res://world/world_area.tscn"


func _on_world_area_button_pressed() -> void:
	get_tree().change_scene_to_file(world_area)


func _on_bug_report_button_pressed():
	OS.shell_open("https://forms.gle/Qnh2vkp6ysoavD3cA")


func _on_new_game_button_pressed():
	DirAccess.remove_absolute("user://save.ffs")
	get_tree().change_scene_to_file(world_area)
