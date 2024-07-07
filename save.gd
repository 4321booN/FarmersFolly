extends Node


var world_area: Node2D
var inventory: Array = Inventory.inventory
var player_position: Vector2
var player_health: int
var player_hunger: int


func savegame() -> void:
	var save_file: FileAccess = FileAccess.open("user://", FileAccess.WRITE)
	if FileAccess.file_exists("user://save.ffs"):
		save_file = FileAccess.open("user://save.ffs", FileAccess.WRITE)
	else:
		printerr("Could not find 'user://save.ffs'. Creating...")
		save_file = FileAccess.open("user://save.ffs", FileAccess.WRITE)
	FileAccess.get_open_error()
	save_file.store_float(player_position.x)
	save_file.store_float(player_position.y)
	save_file.store_8(player_health)
	save_file.store_8(player_hunger)
	for i in 2:
		save_file.store_8(i)
		for x: int in 32:
			for y: int in 25:
				save_file.store_8(world_area.get_tile_data(i, Vector2i(x - 16, y - 13), true))
	save_file.store_8(inventory.size())
	for i in inventory.size():
		save_file.store_pascal_string(inventory[i]["item"])
		save_file.store_8(inventory[i]["count"])
	save_file.close()
