extends Node


var textures: Dictionary = {
	'brick_oven' : ResourceLoader.load('res://objects/item/brick_oven.png'),
	'brick_tile' : ResourceLoader.load('res://objects/item/brick_tile.png'),
	"stone_oven" : ResourceLoader.load("res://objects/item/stone_oven.png"),
	'workbench' : ResourceLoader.load('res://objects/item/workbench.png')}

var display_names: Dictionary = {
	"ff:brick_oven":"Brick Oven",
	"ff:brick_tile":"Brick Tile",
	"ff:stone_oven":"Stone Oven",
	"ff:workbench":"Workbench"}

var tools: PackedStringArray = []

var tooltiers: Dictionary = {}

var tooltypes: Dictionary = {}

var foods: Dictionary = {}

var seeds: Dictionary = {}

var placeables: PackedStringArray = [
	"ff:workbench",
	"ff:stone_oven",
	"ff:brick_oven",
	"ff:brick_tile"
]

var placeables_ids: Dictionary = {
	"ff:workbench" : 4,
	"ff:stone_oven" : 6,
	"ff:brick_oven" : 14,
	"ff:brick_tile" : 15
}

var tile_atlas_pos: PackedVector2Array = [
	Vector2(0,0), #Nothing
	Vector2(1,0), #Grass Top
	Vector2(0,1), #Water
	Vector2(1,1), #Grass Side
	Vector2(0,0), #Workbench
	Vector2(0,0), #Tree
	Vector2(0,0), #Stone Oven
	Vector2(0,0), #Iron Ore
	Vector2(0,0), #Boulder
	Vector2(0,0), #Tall Grass
	Vector2(0,0), #Berry Bush
	Vector2(0,0), #Copper Ore
	Vector2(0,0), #Hole
	Vector2(0,0), #Berry Bush Crop
	Vector2(0,0), #Brick Oven
	Vector2(2,0), #Brick Tile
]


func _ready() -> void:
	for i in Load.items:
		display_names.merge({i["reg_name"]:i["display_name"]})
		textures.merge({i["reg_name"]:ResourceLoader.load("res://objects/item/" +i["texture"])})
		if i["type"] == "normal":
			pass
		elif i["type"] == "tool":
			tools.append(i["reg_name"])
			if tooltiers.has(i["tool_tier"]):
				tooltiers.i["tool_tier"].append(i["reg_name"])
			else:
				tooltiers.merge({i["tool_tier"]:[]})
				tooltiers.i["tool_tier"].append(i["reg_name"])
			if tooltypes.has(i["tool_type"]):
				tooltypes.i["tool_type"].append(i["reg_name"])
			else:
				tooltypes.merge({i["tool_type"]:[]})
				tooltypes.i["tool_type"].append(i["reg_name"])
		elif i["type"] == "food":
			foods.merge({i["reg_name"]:[i["hunger_restored"], i["health_restored"]]})
		elif i["type"] == "seed":
			foods.merge({i["reg_name"]:i["crop"]})


func get_item_display_name(item: String) -> String:
	return display_names.get(item)

func get_item_texture(item: String) -> Texture2D:
	return textures[item]

func is_item_tool(item: String) -> bool:
	return tools.has(item)

func is_item_pickaxe(item: String) -> bool:
	return tooltypes["ff:pickaxe"].get(item)

func is_item_axe(item: String) -> bool:
	return tooltypes["ff:axe"].get(item)

func is_item_shovel(item: String) -> bool:
	return tooltypes["ff:shovel"].get(item)

func is_item_food(item: String) -> bool:
	return foods.has(item)

func get_food_value(item: String) -> int:
	return foods.get(item)

func is_item_seed(item: String) -> bool:
	return seeds.has(item)

func is_item_placeable(item: String) -> bool:
	return placeables.has(item)

func get_placeable_id(item: String) -> int:
	return placeables_ids[item]

func is_tile_placeable_item(tile: int) -> bool:
	if placeables_ids.find_key(tile):
		return true
	else:
		return false

func get_tile_item(tile: int) -> String:
	return placeables_ids.find_key(tile)
