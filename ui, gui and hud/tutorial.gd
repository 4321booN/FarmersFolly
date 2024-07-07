extends Control

const main_menu: String = "res://ui, gui and hud/title_screen.tscn"


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file(main_menu)
