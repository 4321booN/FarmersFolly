extends StaticBody2D


@onready var popup: Window = $WorkbenchPopup
@onready var control: Control = $WorkbenchPopup/Control
@onready var sprite: Sprite2D = $Sprite2D
@onready var player: CharacterBody2D = $"../../Player"
@onready var recipe_container = $WorkbenchPopup/Control/HBoxContainer/MarginContainer/HBoxContainer/ScrollContainer/RecipeContainer

var recipes: Array = [
	{
		"ingredients" : [
			{
				"item" : "stick",
				"count" : 1
			},
			{
				"item" : "fiber",
				"count" : 1
			},
			{
				"item" : "stone",
				"count" : 2
			}
		],
		"delay" : 0,
		"result" : "stone_pickaxe"
	},
	{
		"ingredients" : [
			{
				"item" : "fiber",
				"count" : 2
			}
		],
		"delay" : 0,
		"result" : "string"
	},
	{
		"ingredients" : [
			{
				"item" : "stick",
				"count" : 1
			},
			{
				"item" : "fiber",
				"count" : 1
			},
			{
				"item" : "stone",
				"count" : 1
			}
		],
		"delay" : 0,
		"result" : "stone_axe"
	},
	{
		"ingredients" : [
			{
				"item" : "stick",
				"count" : 8
			},
			{
				"item" : "stone",
				"count" : 1
			}
		],
		"delay" : 0,
		"result" : "workbench"
	},
	{
		"ingredients" : [
			{
				"item" : "stone",
				"count" : 8
			},
			{
				"item" : "clay",
				"count" : 2
			}
		],
		"delay" : 0,
		"result" : "stone_oven"
	},
]
var mouse_touching: bool = false
var just_placed: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i: int in recipes.size():
		var scene: PackedScene = load("res://ui, gui and hud/recipe.tscn")
		var scene_instance = scene.instantiate()
		scene_instance.set_name("recipe")
		recipe_container.add_child(scene_instance)
		recipe_container.get_child(i).result_texture.texture = ItemParser.textures[recipes[i]["result"]]
		recipe_container.get_child(i).result_label.text = ItemParser.names[recipes[i]["result"]]
		for j: int in recipes[i]["ingredients"].size():
			if j == 0:
				recipe_container.get_child(i).ingredient_texture0.texture = ItemParser.textures[recipes[i]["ingredients"][j]["item"]]
				recipe_container.get_child(i).ingredient_label0.text = ItemParser.names[recipes[i]["ingredients"][j]["item"]] + " x" + str(recipes[i]["ingredients"][j]["count"])
				recipe_container.get_child(i).delay = recipes[i]["delay"]
			if j == 1:
				recipe_container.get_child(i).ingredient_texture1.texture = ItemParser.textures[recipes[i]["ingredients"][j]["item"]]
				recipe_container.get_child(i).ingredient_label1.text = ItemParser.names[recipes[i]["ingredients"][j]["item"]] + " x" + str(recipes[i]["ingredients"][j]["count"])
				recipe_container.get_child(i).delay = recipes[i]["delay"]
			if j == 2:
				recipe_container.get_child(i).ingredient_texture2.texture = ItemParser.textures[recipes[i]["ingredients"][j]["item"]]
				recipe_container.get_child(i).ingredient_label2.text = ItemParser.names[recipes[i]["ingredients"][j]["item"]] + " x" + str(recipes[i]["ingredients"][j]["count"])
				recipe_container.get_child(i).delay = recipes[i]["delay"]
			if j == 3:
				recipe_container.get_child(i).ingredient_texture3.texture = ItemParser.textures[recipes[i]["ingredients"][j]["item"]]
				recipe_container.get_child(i).ingredient_label3.text = ItemParser.names[recipes[i]["ingredients"][j]["item"]] + " x" + str(recipes[i]["ingredients"][j]["count"])
				recipe_container.get_child(i).delay = recipes[i]["delay"]
			if j == 4:
				recipe_container.get_child(i).ingredient_texture4.texture = ItemParser.textures[recipes[i]["ingredients"][j]["item"]]
				recipe_container.get_child(i).ingredient_label4.text = ItemParser.names[recipes[i]["ingredients"][j]["item"]] + " x" + str(recipes[i]["ingredients"][j]["count"])
				recipe_container.get_child(i).delay = recipes[i]["delay"]
			if j == 5:
				recipe_container.get_child(i).ingredient_texture5.texture = ItemParser.textures[recipes[i]["ingredients"][j]["item"]]
				recipe_container.get_child(i).ingredient_label5.text = ItemParser.names[recipes[i]["ingredients"][j]["item"]] + " x" + str(recipes[i]["ingredients"][j]["count"])
				recipe_container.get_child(i).delay = recipes[i]["delay"]


func _process(_delta: float) -> void:
	if player.position.y < position.y:
		sprite.z_index = 2
	else:
		sprite.z_index = 0
	if just_placed:
		await get_tree().create_timer(1).timeout
	if Input.is_action_just_released("interact") && mouse_touching:
		popup.show()
		player.popup_open = true
	if Input.is_action_just_pressed("exit_ui"):
		popup.hide()
		player.popup_open = false


func _on_button_pressed() -> void:
	popup.hide()
	player.popup_open = false


func _on_area_2d_mouse_entered() -> void:
	mouse_touching = true


func _on_area_2d_mouse_exited():
	mouse_touching = false
