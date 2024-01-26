extends TileMap


var tile_pos: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	tile_pos = local_to_map(Vector2i(get_global_mouse_position()))


func _on_player_change_tile(_atlas: int, tile: Vector2i, atlas: int):
	set_cell(0, tile_pos, atlas, tile)
	print("changed tile")
