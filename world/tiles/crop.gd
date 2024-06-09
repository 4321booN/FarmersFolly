extends StaticBody2D
 
signal change_tile
@onready var tilemap: TileMap = $"../"
@onready var crop_tiles: Dictionary = {
	"berry_bush" : 10
}


func _ready():
	connect("change_tile", tilemap._on_world_area_change_tile)
	emit_signal("change_tile", tilemap.local_to_map(position), 0, Vector2i(0, 0), 13)
	await get_tree().create_timer(35.00).timeout
	emit_signal("change_tile", tilemap.local_to_map(position), 0, Vector2i(0, 0), 10)
