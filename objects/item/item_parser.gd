extends Node

var textures: Dictionary = {
	'clay' : ResourceLoader.load('res://objects/item/clay.png'),
	'copper_axe' : ResourceLoader.load('res://objects/item/copper_axe.png'),
	'copper_ingot' : ResourceLoader.load('res://objects/item/copper_ingot.png'),
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
	'stone_pickaxe' : ResourceLoader.load('res://objects/item/stone_pickaxe.png'),
	'stone_spear' : ResourceLoader.load('res://objects/item/stone_spear.png'),
	'string' : ResourceLoader.load('res://objects/item/string.png'),
}
var names: Dictionary = {
  "clay": "Clay",
  "copper_axe": "Copper Axe",
  "copper_ingot": "Copper Ingot",
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
  "stone_pickaxe": "Stone Pickaxe",
  "stone_spear": "Stone Spear",
  "string": "String"
}

var tools: Array = [
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


func is_item_tool(item: String) -> bool:
	return tools.has(item)
