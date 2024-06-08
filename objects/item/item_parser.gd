extends Node

var textures: Dictionary = {
	'berry' : ResourceLoader.load("res://objects/item/berry.png"),
	'clay' : ResourceLoader.load('res://objects/item/clay.png'),
	'copper_axe' : ResourceLoader.load('res://objects/item/copper_axe.png'),
	'copper_ingot' : ResourceLoader.load('res://objects/item/copper_ingot.png'),
	'copper_ore' : ResourceLoader.load("res://objects/item/copper_ore.png"),
	'copper_pickaxe' : ResourceLoader.load('res://objects/item/copper_pickaxe.png'),
	'copper_shovel' : ResourceLoader.load('res://objects/item/copper_shovel.png'),
	'copper_spear' : ResourceLoader.load('res://objects/item/copper_spear.png'),
	'copper_sword' : ResourceLoader.load('res://objects/item/copper_sword.png'),
	'fiber' : ResourceLoader.load('res://objects/item/fiber.png'),
	'incantarite_axe' : ResourceLoader.load('res://objects/item/incantarite_axe.png'),
	'incantarite_ingot' : ResourceLoader.load('res://objects/item/incantarite_ingot.png'),
	'incantarite_pickaxe' : ResourceLoader.load('res://objects/item/incantarite_pickaxe.png'),
	'incantarite_shovel' : ResourceLoader.load('res://objects/item/incantarite_shovel.png'),
	'incantarite_spear' : ResourceLoader.load('res://objects/item/incantarite_spear.png'),
	'incantarite_sword' : ResourceLoader.load('res://objects/item/incantarite_sword.png'),
	'iron_axe' : ResourceLoader.load('res://objects/item/iron_axe.png'),
	'iron_ingot' : ResourceLoader.load('res://objects/item/iron_ingot.png'),
	'iron_ore' : ResourceLoader.load('res://objects/item/iron_ore.png'),
	'iron_pickaxe' : ResourceLoader.load('res://objects/item/iron_pickaxe.png'),
	'iron_shovel' : ResourceLoader.load('res://objects/item/iron_shovel.png'),
	'iron_spear' : ResourceLoader.load('res://objects/item/iron_spear.png'),
	'iron_sword' : ResourceLoader.load('res://objects/item/iron_sword.png'),
	'leather' : ResourceLoader.load('res://objects/item/leather.png'),
	'steel_axe' : ResourceLoader.load('res://objects/item/steel_axe.png'),
	'steel_ingot' : ResourceLoader.load('res://objects/item/steel_ingot.png'),
	'steel_pickaxe' : ResourceLoader.load('res://objects/item/steel_pickaxe.png'),
	'steel_shovel' : ResourceLoader.load('res://objects/item/steel_shovel.png'),
	'steel_spear' : ResourceLoader.load('res://objects/item/steel_spear.png'),
	'steel_sword' : ResourceLoader.load('res://objects/item/steel_sword.png'),
	'stick' : ResourceLoader.load('res://objects/item/stick.png'),
	'stone' : ResourceLoader.load('res://objects/item/stone.png'),
	'stone_axe' : ResourceLoader.load('res://objects/item/stone_axe.png'),
	"stone_oven" : ResourceLoader.load("res://objects/item/stone_oven.png"),
	'stone_pickaxe' : ResourceLoader.load('res://objects/item/stone_pickaxe.png'),
	'stone_spear' : ResourceLoader.load('res://objects/item/stone_spear.png'),
	'string' : ResourceLoader.load('res://objects/item/string.png'),
	'workbench' : ResourceLoader.load('res://objects/item/workbench.png'),
}
var names: Dictionary = {
  "berry": "Berry",
  "clay": "Clay",
  "copper_axe": "Copper Axe",
  "copper_ingot": "Copper Ingot",
  "copper_ore": "Copper Ore",
  "copper_pickaxe": "Copper Pickaxe",
  "copper_shovel": "Copper Shovel",
  "copper_spear": "Copper Spear",
  "copper_sword": "Copper Sword",
  "fiber": "Fiber",
  "incantarite_axe": "Incantarite Axe",
  "incantarite_ingot": "Incantarite Ingot",
  "incantarite_pickaxe": "Incantarite Pickaxe",
  "incantarite_shovel": "Incantarite Shovel",
  "incantarite_spear": "Incantarite Spear",
  "incantarite_sword": "Incantarite Sword",
  "iron_axe": "Iron Axe",
  "iron_ingot": "Iron Ingot",
  "iron_ore": "Iron Ore",
  "iron_pickaxe": "Iron Pickaxe",
  "iron_shovel": "Iron Shovel",
  "iron_spear": "Iron Spear",
  "iron_sword": "Iron Sword",
  "leather": "Leather",
  "steel_axe": "Steel Axe",
  "steel_ingot": "Steel Ingot",
  "steel_pickaxe": "Steel Pickaxe",
  "steel_shovel": "Steel Shovel",
  "steel_spear": "Steel Spear",
  "steel_sword": "Steel Sword",
  "stick": "Stick",
  "stone": "Stone",
  "stone_axe": "Stone Axe",
  "stone_oven": "Stone Oven",
  "stone_pickaxe": "Stone Pickaxe",
  "stone_spear": "Stone Spear",
  "string": "String",
  "workbench": "Workbench"
}

var tools: PackedStringArray = [
  "copper_axe",
  "copper_pickaxe",
  "copper_shovel",
  "copper_spear",
  "copper_sword",
  "incantarite_axe",
  "incantarite_pickaxe",
  "incantarite_shovel",
  "incantarite_spear",
  "incantarite_sword",
  "iron_axe",
  "iron_pickaxe",
  "iron_shovel",
  "iron_spear",
  "iron_sword",
  "steel_axe",
  "steel_pickaxe",
  "steel_shovel",
  "steel_spear",
  "steel_sword",
  "stone_axe",
  "stone_pickaxe",
  "stone_spear"
]

var placeables: PackedStringArray = [
	"workbench",
	"stone_oven"
]

var placeables_ids: Dictionary = {
	"workbench" : 4,
	"stone_oven" : 6
}

var pickaxes: PackedStringArray = [
	"stone_pickaxe",
	"copper_pickaxe",
	"iron_pickaxe",
	"steel_pickaxe",
	"incantarite_pickaxe"
]

var axes: PackedStringArray = [
	"stone_axe",
	"copper_axe",
	"iron_axe",
	"steel_axe",
	"incantarite_axe"
]

var shovels: PackedStringArray = [
	"stone_shovel",
	"copper_shovel",
	"iron_shovel",
	"steel_shovel",
	"incantarite_shovel"
]

var foods: PackedStringArray = [
	"berry",
]

var food_values: Dictionary = {
	"berry" : 2,
}

func get_food_value(item: String) -> int:
	return food_values.get(item)


func is_item_food(item: String) -> bool:
	return foods.has(item)


func is_item_pickaxe(item: String) -> bool:
	return tools.has(item) && pickaxes.has(item)


func is_item_axe(item: String) -> bool:
	return tools.has(item) && axes.has(item)


func is_item_shovel(item: String) -> bool:
	return tools.has(item) && shovels.has(item)


func get_item_texture(item: String) -> Texture2D:
	return textures[item]

func get_placeable_id(item: String) -> int:
	return placeables_ids[item]


func is_tile_placeable_item(tile: int) -> bool:
	if placeables_ids.find_key(tile):
		return true
	else:
		return false


func get_tile_item(tile: int) -> String:
	return placeables_ids.find_key(tile)


func is_item_placeable(item: String) -> bool:
	return placeables.has(item)


func is_item_tool(item: String) -> bool:
	return tools.has(item)
