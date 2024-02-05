extends Node2D

signal at_mouse_tile_id
var tile_data: TileData
var layer0: int = 0
var tile_pos: Vector2i
var tile_data_layer: String = "tile"
var tile_id: int
@onready var tile_map: TileMap = $TileMap

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _on_player_get_tile_data(retrival_pos: Vector2i) -> void:
#	gets the global coods of the tile at 'retrival_pos'
	tile_pos = tile_map.local_to_map(retrival_pos)
#	gets the data from the 'tile' layer at the coords 'tile_pos'
	tile_data = tile_map.get_cell_tile_data(layer0, tile_pos)
#	checks if the tile actually has data
	if tile_data:
#		sets 'tile_id' to the custom data
		tile_id = tile_data.get_custom_data(tile_data_layer)
		emit_signal("at_mouse_tile_id", tile_id)
	else:
		tile_id = -1
		emit_signal("at_mouse_tile_id", tile_id)
