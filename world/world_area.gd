extends Node2D

signal at_mouse_tile_id
signal change_tile
var tile_data: TileData
var layer0: int = 0
var tile_pos: Vector2i
var tile_data_layer: String = "tile"
var tile_id: int
var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@onready var hotbar_slots: Array = [
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item2",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item3",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item4",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item5",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item6",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item7",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item8",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item9",
	$"CanvasLayer/Control/MarginContainer/MarginContainer/ColorRect/MarginContainer/HBoxContainer/Item10"
]
@onready var player: CharacterBody2D = $Player
@onready var tile_map: TileMap = $TileMap


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	for i: int in len(player.hotbar):
		if i < 10:
			if i == player.c_hbar_slot["slot"]:
				hotbar_slots[i].color_rect.color = Color("8E98B4")
			else:
				hotbar_slots[i].color_rect.color = Color("433f53")
			hotbar_slots[i].texture_rect.texture = ItemParser.textures[player.hotbar[i].item]
			hotbar_slots[i].count_label.text = str(player.hotbar[i].count)
	place_random_tile()


func _on_player_get_tile_data(retrival_pos: Vector2i) -> void:
	get_tile_data(retrival_pos, false)
	emit_signal("at_mouse_tile_id", tile_id)


func place_random_tile():
	#   generates a random position for a tile to spawn at
	var random_pos: Vector2i = Vector2i(rng.randi_range(-7,6),rng.randi_range(-7,6))
	var valid: bool
	# determines whether "random_pos" is a valid location to spawn a tile
	for i: int in player.nothing.size():
		if get_tile_data(random_pos, true) == player.nothing[i]:
			valid = true
			break
		if get_tile_data(random_pos, true) != player.nothing[i]:
			valid = false
	# makes it so that there's a 0.015% chance of a tile actually being placed
	if valid && rng.randi_range(0, 10000) <= 15:
		#change tile:          at: random_pos, atlas: 0, tile: 0,0 (because it's a scenes collection),
		#                      alt_tile: 5
		emit_signal("change_tile", random_pos, 0, Vector2i(0,0), 5)


func get_tile_data(retrival_pos: Vector2i, local_to_map: bool) -> int:
#	gets the global coods of the tile at 'retrival_pos'
	if not local_to_map:
		tile_pos = tile_map.local_to_map(retrival_pos)
	else:
		tile_pos = retrival_pos
#	gets the data from the 'tile' layer at the coords 'tile_pos'
	tile_data = tile_map.get_cell_tile_data(layer0, tile_pos)
#	checks if the tile actually has data
	if tile_data:
#		sets 'tile_id' to the custom data
		tile_id = tile_data.get_custom_data(tile_data_layer)
		return tile_id
	else:
		tile_id = tile_map.get_cell_alternative_tile(layer0, tile_pos)
		if tile_id:
			return tile_id
		else:
			tile_id = -1
			return tile_id


func _on_player_clear_slot(slot):
	hotbar_slots[slot].texture_rect.texture = ResourceLoader.load("res://objects/item/null.png")
	hotbar_slots[slot].count_label.text = ""
	hotbar_slots[slot].color_rect.color = Color("433f53")
