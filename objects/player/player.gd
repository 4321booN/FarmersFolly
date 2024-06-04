extends CharacterBody2D


@onready var tilemap: TileMap = $"../TileMap"
@onready var inventory_popup: Window = $"../InventoryPopup"
@onready var inventory: Array = [
	{
		"item" : "fiber",
		"count" : 10
	},
	{
		"item" : "clay",
		"count" : 2
	},
]
@export var speed: float = 280
@export var dir: int = 0
@export var at_mouse_tile_id: int
var rng = RandomNumberGenerator.new()
var tile_pos: Vector2i
var popup_open: bool = false
var interacables: Array = [4, 5, 6, 7, 8]
var breakables: Array = [4, 5, 6, 7, 8]
var resource_tiles: Array = [5, 7, 8]
var nothing: Array = [1]
var hotbar: Array = []
var reach: float = 320.00
var c_hbar_slot: Dictionary = {
	"slot" : 0,
	"item" : {
		
	}
}
signal get_tile_data
signal change_tile


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:

# MOVEMENT RELATED CODE

	move_and_slide()

	if dir > 3:
		dir = 3
	elif dir < 0:
		dir = 0

	if not is_walking():
		$PlayerSprite.play("idle")
	else:
		$PlayerSprite.play("walk_" + str(dir))

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

	remove_0stacks()

	if not popup_open:
		if Input.is_action_just_released("scroll_u"):
			c_hbar_slot["slot"] += 1
		elif Input.is_action_just_released("scroll_d"):
			c_hbar_slot["slot"] -= 1
		if c_hbar_slot["slot"] < 0:
			c_hbar_slot["slot"] = hotbar.size() - 1
		elif c_hbar_slot["slot"] > hotbar.size() - 1:
			c_hbar_slot["slot"] = 0
	if hotbar.size() > 0:
		c_hbar_slot["item"] = hotbar[c_hbar_slot['slot']]

	hotbar.clear()
	for i: int in inventory.size():
		if ItemParser.is_item_tool(inventory[i]["item"]) or ItemParser.is_item_placeable(inventory[i]["item"]):
			hotbar.append(inventory[i])

	if Input.is_action_just_released("open_inventory"):
		inventory_popup.show()
		popup_open = true

	if Input.is_action_just_pressed("exit_ui"):
		inventory_popup.hide()
		popup_open = false

# WORLD RELATED CODE

	tile_pos = Vector2i(get_global_mouse_position())
	emit_signal("get_tile_data", tile_pos)

	if Input.is_action_just_released("break"):
		if breakables.has(at_mouse_tile_id) and interacables.has(at_mouse_tile_id) and not popup_open and get_local_mouse_position().distance_to(position) <= reach:
			emit_signal("change_tile", 1, Vector2i(1,0), 0)
			if ItemParser.is_tile_placeable_item(at_mouse_tile_id):
				add_inventory_item(ItemParser.get_tile_item(at_mouse_tile_id), 1)
			elif resource_tiles.has(at_mouse_tile_id):
				if at_mouse_tile_id == resource_tiles[0]:
					if c_hbar_slot["item"] != {}:
						if ItemParser.is_item_axe(c_hbar_slot["item"]["item"]):
							add_inventory_item("stick", rng.randi_range(4, 8))
						else:
							add_inventory_item("stick", rng.randi_range(1, 4))
					else:
							add_inventory_item("stick", rng.randi_range(1, 4))
				elif at_mouse_tile_id == resource_tiles[1] && ItemParser.is_item_pickaxe(c_hbar_slot["item"]["item"]):
					add_inventory_item("iron_ore", rng.randi_range(1, 2))
				elif at_mouse_tile_id == resource_tiles[2]:
					if c_hbar_slot["item"] != {}:
						if ItemParser.is_item_pickaxe(c_hbar_slot["item"]["item"]):
							add_inventory_item("stone", rng.randi_range(2, 3))
						else:
							add_inventory_item("stone", rng.randi_range(0, 1))
					else:
							add_inventory_item("stone", rng.randi_range(0, 1))
	elif Input.is_action_pressed("interact"):
		if nothing.has(at_mouse_tile_id) and not interacables.has(at_mouse_tile_id) and not popup_open and get_local_mouse_position().distance_to(position) <= reach:
			if c_hbar_slot["item"]:
				if ItemParser.is_item_placeable(c_hbar_slot["item"]["item"]):
					remove_inventory_item(c_hbar_slot["item"]["item"], 1)
					emit_signal("change_tile", 0, Vector2i(0,0), ItemParser.get_placeable_id(c_hbar_slot["item"]["item"]))
					c_hbar_slot["item"] = {}

# MORE INVENTORY RELATED CODE

func _on_world_area_at_mouse_tile_id(tile_id: int) -> void:
	at_mouse_tile_id = tile_id


func remove_0stacks() -> void:
	for i: int in len(inventory):
		if i < len(inventory):
			if inventory[i]["count"] <= 0:
				inventory.remove_at(i)
	if c_hbar_slot["item"] != {}:
		if c_hbar_slot["item"]["count"] == 0:
			c_hbar_slot["item"] = {}


func add_inventory_item(item: String, count: int) -> void:
	var found: bool = false
	for i: int in len(inventory):
		if inventory[i]['item'] == item && inventory[i]['count'] < 100:
			found = true
			inventory[i]['count'] += count
	if not found:
		inventory.append({
			"item": item,
			"count": count
		})

	@warning_ignore("narrowing_conversion")
	z_index = 415 + position.y

func remove_inventory_item(item: String, count: int) -> void:
	for i: int in len(inventory):
		if inventory[i]['item'] == item && inventory[i]['count'] > 0:
			inventory[i]['count'] -= count


func inventory_has_item(item: String, count: int) -> bool:
	var found: bool = false
	for i: int in len(inventory):
		if count > 0:
			if inventory[i]['item'] == item && inventory[i]['count'] >= count:
				found = true
				break
			else:
				found = false
		elif count <= 0:
			if inventory[i]['item'] == item:
				found = true
				break
			else:
				found = false
	return found


func is_walking() -> bool:
	return (Input.is_action_pressed("walk_d")
		 or Input.is_action_pressed("walk_u")
		 or Input.is_action_pressed("walk_r")
		 or Input.is_action_pressed("walk_l"))
