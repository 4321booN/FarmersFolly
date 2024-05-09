extends TileMap

@onready var player: CharacterBody2D = $"../Player"
var tile_pos: Vector2i

func _process(_delta):
#	Sets the tile_pos to a Intergerized Global Mouse Position
	tile_pos = local_to_map(Vector2i(get_global_mouse_position()))

#	A signal recived from the player, calling a manual tile change
func _on_player_change_tile(tile: Vector2i, atlas: int):
#	Set the tile in layer: 0 at position: tile_pos to tile: tile from atlas: atlas
	set_cell(0, tile_pos, atlas, tile)
	print("changed tile")
