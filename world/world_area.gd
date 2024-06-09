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
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item2,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item3,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item4,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item5,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item6,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item7,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item8,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item9,
	$CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/ColorRect/MarginContainer/HBoxContainer/Item10
]
@onready var health_bar: ProgressBar = $CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/HealthBar
@onready var hunger_bar: ProgressBar = $CanvasLayer/Control/MarginContainer/MarginContainer/VBoxContainer/HBoxContainer/HungerBar
@onready var player: CharacterBody2D = $Player
@onready var tile_map: TileMap = $TileMap
@onready var player_inventory: Control = $InventoryPopup/Control/HBoxContainer/MarginContainer/HBoxContainer/PlayerInventory
@onready var inventory_popup: Window = $InventoryPopup
@onready var esc_menu: Window = $ESCMenu



func _ready() -> void:
	player_inventory.player = player

func _process(_delta: float) -> void:
	health_bar.value = player.health
	hunger_bar.value = player.hunger
	for i: int in player.hotbar.size():
		if i < 10:
			if i == player.c_hbar_slot["slot"]:
				hotbar_slots[i].color_rect.color = Color("8E98B4")
			else:
				hotbar_slots[i].color_rect.color = Color("433f53")
			hotbar_slots[i].texture_rect.texture = ItemParser.textures[player.hotbar[i].item]
			hotbar_slots[i].count_label.text = str(player.hotbar[i].count)
			if str_to_var(hotbar_slots[i].count_label.text) == 0:
				hotbar_slots[i].texture_rect.texture = ResourceLoader.load("res://objects/item/null.png")
				hotbar_slots[i].count_label.text = ""
				hotbar_slots[i].color_rect.color = Color("433f53")
	for i: int in hotbar_slots.size():
		if not player.hotbar.size() - 1 >= i:
			hotbar_slots[i].texture_rect.texture = ResourceLoader.load("res://objects/item/null.png")
			hotbar_slots[i].count_label.text = ""
			hotbar_slots[i].color_rect.color = Color("433f53")
	place_random_tile()
	if not player.popup_open:
		if Input.is_action_just_released("exit_ui"):
			esc_menu.show()
			player.popup_open = true


func _on_player_get_tile_data(retrival_pos: Vector2i) -> void:
	get_tile_data(retrival_pos, false)
	emit_signal("at_mouse_tile_id", tile_id)


func place_random_tile():
	rng.randomize()
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
	# makes it so that there's a 0.007% chance of a tile (tree) actually being placed
	if valid && rng.randi_range(0, 10000) <= 7:
		#change tile:          at: random_pos, atlas: 0, tile: 0,0 (because it's a scenes collection),
		#                      alt_tile: 5
		emit_signal("change_tile", random_pos, 0, Vector2i(0,0), 5)
		#                        0.004% copper_ore
	if valid && rng.randi_range(0, 10000) <= 4:
		emit_signal("change_tile", random_pos, 0, Vector2i(0,0), 11)
		#                        0.005% boulder
	if valid && rng.randi_range(0, 10000) <= 5:
		emit_signal("change_tile", random_pos, 0, Vector2i(0,0), 8)
		#                        0.07% tall_grass
	if valid && rng.randi_range(0, 1000) <= 7:
		emit_signal("change_tile", random_pos, 0, Vector2i(0,0), 9)
		#                        0.01% berry_bush
	if valid && rng.randi_range(0, 1000) <= 1:
		emit_signal("change_tile", random_pos, 0, Vector2i(0,0), 10)


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


func _on_quit_to_title_button_pressed():
	get_tree().change_scene_to_file("res://ui, gui and hud/title_screen.tscn")


func _on_bug_report_button_pressed():
	OS.shell_open("https://forms.gle/X4pBBBYXa74AkYTc9")


func _on_back_to_game_button_pressed():
	player.popup_open = false
	esc_menu.hide()


func _on_button_pressed():
	player.popup_open = false
	inventory_popup.hide()
