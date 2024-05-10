extends CharacterBody2D


@onready var tilemap: TileMap = $"../TileMap"
@onready var inventory: Array = [
	{
		"item" : "stone",
		"count" : 10
	},
	{
		"item" : "fiber",
		"count" : 10
	},
	{
		"item" : "stick",
		"count" : 10
	}
]
@export var speed: float = 280
@export var dir: int = 0
@export var at_mouse_tile_id: int
var tile_pos: Vector2i
var popup_open: bool = false
var interacables: Array = [2, 3]
var breakables: Array = [2, 3]
var nothing: Array = [-1, 0]
signal get_tile_data
signal change_tile


func _ready():
	pass


func _physics_process(_delta: float):
	tile_pos = Vector2i(get_global_mouse_position())
	emit_signal("get_tile_data", tile_pos)

	move_and_slide()
	remove_0stacks()

	if dir > 3:
		dir = 3
	elif dir < 0:
		dir = 0

	if not is_walking():
		$PlayerSprite.play("idle")
	else:
		$PlayerSprite.play("walk_" + str(dir))

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


func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_released("break"):
			for i in len(breakables):
				for j in len(interacables):
					if at_mouse_tile_id == breakables[i] and not popup_open:
						if at_mouse_tile_id == interacables[j]:
							emit_signal("change_tile", Vector2i(1,0), 1)
							break
						else:
							emit_signal("change_tile", Vector2i(0,0), 1)
							break
		elif event.is_action_pressed("interact"):
			for j in len(nothing):
				for k in len(interacables):
					if at_mouse_tile_id == nothing[j] and at_mouse_tile_id != interacables[k] and not popup_open:
						emit_signal("change_tile", Vector2i(1,0), 1)


func _on_world_area_at_mouse_tile_id(tile_id: int) -> void:
	at_mouse_tile_id = tile_id


func remove_0stacks():
	for i: int in len(inventory):
		if i < len(inventory):
			if inventory[i]["count"] <= 0:
				inventory.remove_at(i)

func add_inventory_item(item: String, count: int):
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


func remove_inventory_item(item: String, count: int):
	for i: int in len(inventory):
		if inventory[i]['item'] == item && inventory[i]['count'] > 0:
			inventory[i]['count'] -= count


func inventory_has_item(item: String, count: int):
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


func is_walking():
	return (Input.is_action_pressed("walk_d")
		 or Input.is_action_pressed("walk_u")
		 or Input.is_action_pressed("walk_r")
		 or Input.is_action_pressed("walk_l"))
