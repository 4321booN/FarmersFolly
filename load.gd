extends Node


var tilemap: TileMap
var atlas0_tiles: Array
var atlas1_tiles: Array
var inventory_size: int
var player_position: Vector2
var player_health: int
var player_hunger: int
var new_save: bool = false


func loadgame() -> void:
	var save_file: FileAccess = FileAccess.open("user://", FileAccess.READ)
	if FileAccess.file_exists("user://save.ffs"):
		save_file = FileAccess.open("user://save.ffs", FileAccess.READ)
	else:
		printerr("Could not find 'user://save.ffs'. Creating...")
		save_file = FileAccess.open("user://save.ffs", FileAccess.WRITE_READ)
	FileAccess.get_open_error()
	if save_file.get_length() > 16:
		player_position = Vector2(save_file.get_float(),save_file.get_float())
		player_health = save_file.get_8()
		player_hunger = save_file.get_8()
		PlayerNode.player.position = player_position
		PlayerNode.player.health = player_health
		PlayerNode.player.hunger = player_hunger
		for i in 2:
			var layer: int = save_file.get_8()
			for x: int in 32:
				for y: int in 25:
					var tile_id: int = save_file.get_8()
					if atlas0_tiles.has(tile_id):
						tilemap.load_tile(Vector2i(x-16,y-13), layer, 0, ItemParser.tile_atlas_pos[tile_id], tile_id)
					elif atlas1_tiles.has(tile_id):
						tilemap.load_tile(Vector2i(x-16,y-13), layer, 1, ItemParser.tile_atlas_pos[tile_id], 0)
		inventory_size = save_file.get_8()
		for i in inventory_size:
			Inventory.inventory.append({"item": save_file.get_pascal_string(), "count": save_file.get_8()})
	else:
		new_save = true
		pass
	save_file.close()
