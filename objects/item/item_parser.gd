extends Node

var textures: Dictionary = {
	"clay" : ResourceLoader.load("res://objects/item/clay.png"),
	"copper_ingot" : ResourceLoader.load("res://objects/item/copper_ingot.png"),
	"fiber" : ResourceLoader.load("res://objects/item/fiber.png"),
	"iron_ingot" : ResourceLoader.load("res://objects/item/iron_ingot.png"),
	"leather" : ResourceLoader.load("res://objects/item/leather.png"),
	"steel_ingot" : ResourceLoader.load("res://objects/item/steel_ingot.png"),
	"stick" : ResourceLoader.load("res://objects/item/stick.png"),
	"stone" : ResourceLoader.load("res://objects/item/stone.png"),
	"stone_axe" : ResourceLoader.load("res://objects/item/stone_axe.png"),
	"stone_pickaxe" : ResourceLoader.load("res://objects/item/stone_pickaxe.png"),
	"stone_spear" : ResourceLoader.load("res://objects/item/stone_spear.png"),
	"string" : ResourceLoader.load("res://objects/item/string.png")
}
var names: Dictionary = {
	"clay" : "Clay",
	"copper_ingot" : "Copper Ingot",
	"fiber" : "Fiber",
	"iron_ingot" : "Iron Ingot",
	"leather" : "Leather",
	"steel_ingot" : "Steel Ingot",
	"stick" : "Stick",
	"stone" : "Stone",
	"stone_axe" : "Stone Axe",
	"stone_pickaxe" : "Stone Pickaxe",
	"stone_spear" : "Stone Spear",
	"string" : "String"
}

var tools: Array = [
	"stone_pickaxe",
	"stone_axe",
	"stone_spear"
]
