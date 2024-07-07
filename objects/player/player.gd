extends CharacterBody2D


@onready var tilemap: TileMap = $"../TileMap"
@onready var inventory_popup: Window = $"../InventoryPopup"
@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@export var speed: float = 280
@export var health: int = 8
@export var hunger: int = 16
var stat_decay: float = 0.00
@export var dir: int = 0
@export var at_mouse_tile_id: int
@export var bg_mouse_tile_id: int
var rng = RandomNumberGenerator.new()
var tile_pos: Vector2i
var popup_open: bool = false
var interacables: Array = [4, 6, 14]
var breakables: Array = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
var bg_tiles: Array = [15]
var bg_tiles_tiles: PackedVector2Array = [
	Vector2i(2, 0)
]
var resource_tiles: Array = [5, 7, 8, 9, 10, 11]
var nothing: Array = [-1, 0, 1, 9]
var reach: float = 320.00
signal get_tile_data
signal get_bg_tile_data
signal change_tile


func _ready() -> void:
	PlayerNode.player = self
	var atlas0_tiles: Array = breakables
	for i in bg_tiles.size():
		atlas0_tiles.erase(bg_tiles[i])
	Load.atlas0_tiles = atlas0_tiles
	var atlas1_tiles: Array = bg_tiles
	atlas1_tiles.append_array([0,1,2,3])
	Load.atlas1_tiles = atlas1_tiles


func _physics_process(delta: float) -> void:
	Save.player_position = position
	Save.player_health = health
	Save.player_hunger = hunger
#	@warning_ignore("narrowing_conversion")
#	z_index = 415 + position.y

# MOVEMENT RELATED CODE

	move_and_slide()

	if dir > 3:
		dir = 3
	elif dir < 0:
		dir = 0

	if not is_walking() && not popup_open:
		var idle_dir: String
		if dir > 1:
			idle_dir = "1"
		else:
			idle_dir = "0"
		player_sprite.play("idle_" + idle_dir)
	elif not popup_open:
		player_sprite.play("walk_" + str(dir))

	if not popup_open:
		if Input.is_action_pressed("walk_l"):
			velocity[0] = -speed
			dir = 3
		elif Input.is_action_pressed("walk_r"):
			velocity[0] = speed
			dir = 1
		else:
			velocity[0] = 0

		if Input.is_action_pressed("walk_u"):
			velocity[1] = -speed
			dir = 0
		elif Input.is_action_pressed("walk_d"):
			velocity[1] = speed
			dir = 2
		else:
			velocity[1] = 0

#INVENTORY RELATED CODE

	Inventory.remove_0stacks()

	if not popup_open:
		if Input.is_action_just_released("scroll_u"):
			Inventory.c_hbar_slot["slot"] += 1
		elif Input.is_action_just_released("scroll_d"):
			Inventory.c_hbar_slot["slot"] -= 1
		if Inventory.c_hbar_slot["slot"] < 0:
			Inventory.c_hbar_slot["slot"] = Inventory.hotbar.size() - 1
		elif Inventory.c_hbar_slot["slot"] > Inventory.hotbar.size() - 1:
			Inventory.c_hbar_slot["slot"] = 0
	if Inventory.hotbar.size() > 0:
		Inventory.c_hbar_slot["item"] = Inventory.hotbar[Inventory.c_hbar_slot['slot']]

	Inventory.hotbar.clear()
	for i: int in Inventory.inventory.size():
		if ItemParser.is_item_tool(Inventory.inventory[i]["item"]) or ItemParser.is_item_placeable(Inventory.inventory[i]["item"]) or ItemParser.is_item_food(Inventory.inventory[i]["item"]) or ItemParser.is_item_seed(Inventory.inventory[i]["item"]):
			Inventory.hotbar.append(Inventory.inventory[i])

	if Input.is_action_just_released("open_inventory"):
		inventory_popup.show()
		popup_open = true

# WORLD RELATED CODE
#	prints(str(at_mouse_tile_id), str(bg_mouse_tile_id))
	tile_pos = Vector2i(get_global_mouse_position())
	emit_signal("get_tile_data", tile_pos)
	emit_signal("get_bg_tile_data", tile_pos)

	if Input.is_action_just_released("break"):
		tilemap.update_internals()
		if (breakables.has(at_mouse_tile_id) or breakables.has(bg_mouse_tile_id)) and not popup_open and get_local_mouse_position().distance_to(position) <= reach:
			emit_signal("change_tile", 0, 1, Vector2i(0,0), 0)
			emit_signal("change_tile", 1, 1, Vector2i(1,0), 0)
			if ItemParser.is_tile_placeable_item(at_mouse_tile_id):
				Inventory.add_inventory_item(ItemParser.get_tile_item(at_mouse_tile_id), 1)
			if bg_tiles.has(bg_mouse_tile_id) and ItemParser.is_tile_placeable_item(bg_mouse_tile_id):
				Inventory.add_inventory_item(ItemParser.get_tile_item(bg_mouse_tile_id), 1)
			if resource_tiles.has(at_mouse_tile_id):
				if at_mouse_tile_id == resource_tiles[0]:
					if Inventory.c_hbar_slot["item"] != {}:
						if ItemParser.is_item_axe(Inventory.c_hbar_slot["item"]["item"]):
							Inventory.add_inventory_item("stick", rng.randi_range(4, 8))
						else:
							Inventory.add_inventory_item("stick", rng.randi_range(1, 4))
					else:
						Inventory.add_inventory_item("stick", rng.randi_range(1, 4))
				elif at_mouse_tile_id == resource_tiles[1] && ItemParser.is_item_pickaxe(Inventory.c_hbar_slot["item"]["item"]):
					Inventory.add_inventory_item("iron_ore", rng.randi_range(1, 2))
					Inventory.add_inventory_item("stone", rng.randi_range(0, 1))
				elif at_mouse_tile_id == resource_tiles[2]:
					if Inventory.c_hbar_slot["item"] != {}:
						if ItemParser.is_item_pickaxe(Inventory.c_hbar_slot["item"]["item"]):
							Inventory.add_inventory_item("stone", rng.randi_range(2, 3))
						else:
							Inventory.add_inventory_item("stone", rng.randi_range(0, 1))
					else:
							Inventory.add_inventory_item("stone", rng.randi_range(0, 1))
					if rng.randf() > .8:
								Inventory.add_inventory_item("clay", 1)
				elif at_mouse_tile_id == resource_tiles[3]:
					Inventory.add_inventory_item("fiber", rng.randi_range(2, 4))
				elif at_mouse_tile_id == resource_tiles[4]:
					Inventory.add_inventory_item("berry", rng.randi_range(1, 3))
				elif at_mouse_tile_id == resource_tiles[5] && ItemParser.is_item_pickaxe(Inventory.c_hbar_slot["item"]["item"]):
					Inventory.add_inventory_item("copper_ore", rng.randi_range(1, 3))
	elif Input.is_action_just_released("interact"):
		tilemap.update_internals()
		if not popup_open and get_local_mouse_position().distance_to(position) <= reach and Inventory.c_hbar_slot["item"] != {}:
			if ItemParser.is_item_placeable(Inventory.c_hbar_slot["item"]["item"]) and not bg_tiles.has(ItemParser.get_placeable_id(Inventory.c_hbar_slot["item"]["item"])) and nothing.has(at_mouse_tile_id):
				Inventory.remove_inventory_item(Inventory.c_hbar_slot["item"]["item"], 1)
				emit_signal("change_tile", 0, 0, Vector2i(0,0), ItemParser.get_placeable_id(Inventory.c_hbar_slot["item"]["item"]))
				Inventory.c_hbar_slot["item"] = {}
			if ItemParser.is_item_placeable(Inventory.c_hbar_slot["item"]["item"]) and bg_tiles.has(ItemParser.get_placeable_id(Inventory.c_hbar_slot["item"]["item"])) and nothing.has(bg_mouse_tile_id):
				Inventory.remove_inventory_item(Inventory.c_hbar_slot["item"]["item"], 1)
				if nothing.has(at_mouse_tile_id):
					emit_signal("change_tile", 0, 1, Vector2i(0,0), 0)
				emit_signal("change_tile", 1, 1, bg_tiles_tiles[bg_tiles.find(ItemParser.get_placeable_id(Inventory.c_hbar_slot["item"]["item"]))], 0)
				Inventory.c_hbar_slot["item"] = {}
			elif ItemParser.is_item_food(Inventory.c_hbar_slot["item"]["item"]) && hunger < 16:
				Inventory.remove_inventory_item(Inventory.c_hbar_slot["item"]["item"], 1)
				hunger += ItemParser.get_food_value(Inventory.c_hbar_slot["item"]["item"])
				Inventory.c_hbar_slot["item"] = {}
			elif ItemParser.is_item_shovel(Inventory.c_hbar_slot["item"]["item"]) and nothing.has(at_mouse_tile_id):
				Inventory.add_inventory_item("clay", rng.randi_range(1, 2))
				emit_signal("change_tile", 0, 0, Vector2i(0,0), 12)
			elif ItemParser.is_item_seed(Inventory.c_hbar_slot["item"]["item"]) && at_mouse_tile_id == breakables[8]:
				Inventory.remove_inventory_item(Inventory.c_hbar_slot["item"]["item"], 1)
				emit_signal("change_tile", 0, 0, Vector2i(0,0), 13)
				Inventory.c_hbar_slot["item"] = {}


	stat_decay += delta
	if hunger > 16:
		hunger = 16
	if health > 8:
		health = 8
	if stat_decay >= 30 && hunger > 0:
		hunger -= 1
		stat_decay = 0.00
	elif stat_decay >= 30:
		health -= 1
		stat_decay = 0.00
	if health == 0:
		await get_tree().create_timer(3).timeout
		queue_free()


func _on_world_area_at_mouse_tile_id(tile_id: int) -> void:
	at_mouse_tile_id = tile_id


func is_walking() -> bool:
	return (Input.is_action_pressed("walk_d")
		 or Input.is_action_pressed("walk_u")
		 or Input.is_action_pressed("walk_r")
		 or Input.is_action_pressed("walk_l"))


func _on_world_area_bg_mouse_tile_id(tile_id: int) -> void:
	bg_mouse_tile_id = tile_id
