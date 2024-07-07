extends Node


@onready var tilemap: TileMap
var atlas0_tiles: Array
var atlas1_tiles: Array
var connected: bool = false
signal change_tile


func _ready() -> void:
	pass


func _process(_delta) -> void:
	if not connected and get_tree_string().contains("WorldArea"):
		connect("change_tile", tilemap._on_load_change_tile)
		connected = true


func loadgame() -> void:
	var save_file: FileAccess = FileAccess.open("user://save.dat", FileAccess.READ)
	FileAccess.get_open_error()
	for i in 1:
		var layer: int = save_file.get_8()
		print(str(layer))
		for x: int in 31:
			for y: int in 24:
				var tile_id: int = save_file.get_8()
				if layer == 0:
					emit_signal("change_tile", layer, Vector2i(x-16,y-13), layer, ItemParser.tile_atlas_pos[tile_id], tile_id)
				elif layer == 1:
					emit_signal("change_tile", layer, Vector2i(x-16,y-13), layer, ItemParser.tile_atlas_pos[tile_id], 0)
