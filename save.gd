extends Node


var world_area: Node2D
var inventory: Array = Inventory.inventory
var player_position: Vector2
var player_health: int
var player_hunger: int









func savegame() -> void:
	var save_file: FileAccess = FileAccess.open("user://save.dat", FileAccess.WRITE)
	FileAccess.get_open_error()
	for i in 1:
		save_file.store_8(i)
		for x: int in 31:
			for y: int in 24:
				save_file.store_8(world_area.get_tile_data(i, Vector2i(x - 16, y - 13), true))
	save_file.store_var(inventory)
	save_file.store_float(player_position.x)
	save_file.store_float(player_position.y)
	save_file.store_8(player_health)
	save_file.store_8(player_hunger)
