extends TileMap

@onready var player: CharacterBody2D = $"../Player"
var tile_pos: Vector2i

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	tile_pos = local_to_map(Vector2i(get_global_mouse_position()))

	set_layer_z_index(0, player.z_index - 1)
	set_layer_z_index(1, player.z_index + 1)


func _on_player_change_tile(_atlas: int, tile: Vector2i, atlas: int):
	set_cell(0, tile_pos, atlas, tile)
	print("changed tile")
