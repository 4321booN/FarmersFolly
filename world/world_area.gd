extends Node2D

signal at_mouse_tile_id
var tile_data: TileData
var layer0: int = 0
var tile_pos: Vector2i
var tile_data_layer: String = "tile"
var tile_id: int
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
		tile_id = tile_map.get_cell_alternative_tile(layer0, tile_pos)
		if tile_id:
			emit_signal("at_mouse_tile_id", tile_id)
		else:
			tile_id = -1
			emit_signal("at_mouse_tile_id", tile_id)


func _on_player_clear_slot(slot):
	hotbar_slots[slot].texture_rect.texture = ResourceLoader.load("res://objects/item/null.png")
	hotbar_slots[slot].count_label.text = ""
	hotbar_slots[slot].color_rect.color = Color("433f53")
