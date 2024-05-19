extends Control

const world_area: String = "res://world/world_area.tscn"


func _on_world_area_button_pressed() -> void:
	get_tree().change_scene_to_file(world_area)
