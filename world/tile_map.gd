extends TileMap

@onready var player: CharacterBody2D = %Player
var tile_pos: Vector2i

func _process(_delta: float) -> void:
	set_layer_z_index(0, player.z_index - 1)
	set_layer_z_index(1, -415)
#	Sets the tile_pos to a Intergerized Global Mouse Position
	tile_pos = local_to_map(Vector2i(get_global_mouse_position()))

#	A signal recived from the player, calling a manual tile change
func _on_player_change_tile(layer: int, atlas: int, tile: Vector2i, alt_tile: int) -> void:
#	Set the tile in layer: layer at position: tile_pos to tile: tile from atlas: atlas
#	print("layer: ", str(layer),", atlas: ", str(atlas), ", tile: ", str(tile), ", alt_tile: ", str(alt_tile))
	set_cell(layer, tile_pos, atlas, tile, alt_tile)


func _on_world_area_change_tile(pos: Vector2i, atlas: int, tile: Vector2i, alt_tile: int) -> void:
	set_cell(0, pos, atlas, tile, alt_tile)
