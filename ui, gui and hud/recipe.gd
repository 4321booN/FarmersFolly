extends Control

@onready var player: CharacterBody2D = $"../../../../../../../../../../Player"
@onready var result_texture: TextureRect = $ColorRect/HBoxContainer/ResultTexture
@onready var result_label: Label = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer2/ResultLabel
@onready var ingredient_label0: Label = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/IngredientLabel
@onready var ingredient_texture0: TextureRect = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/IngredientTexture
@onready var ingredient_label1: Label = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/IngredientLabel
@onready var ingredient_texture1: TextureRect = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer2/IngredientTexture
@onready var ingredient_label2: Label = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/IngredientLabel
@onready var ingredient_texture2: TextureRect = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer3/IngredientTexture
@onready var ingredient_label3: Label = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/IngredientLabel
@onready var ingredient_texture3: TextureRect = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/IngredientTexture
@onready var ingredient_label4: Label = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/IngredientLabel
@onready var ingredient_texture4: TextureRect = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer2/IngredientTexture
@onready var ingredient_label5: Label = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/IngredientLabel
@onready var ingredient_texture5: TextureRect = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer3/IngredientTexture
var delay: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_craft_button_pressed() -> void:
	if player_has_item(ingredient_label0) && player_has_item(ingredient_label1) && player_has_item(ingredient_label2) && player_has_item(ingredient_label3) && player_has_item(ingredient_label4) && player_has_item(ingredient_label5):
		var is_crafted: bool
		#      is_item_tool(        this_recipe's_item                         )
		if not ItemParser.tools.has(ItemParser.names.find_key(result_label.text)):
			await get_tree().create_timer(delay).timeout
			player.add_inventory_item(ItemParser.names.find_key(result_label.text), 1)
			is_crafted = true
		elif ItemParser.tools.has(ItemParser.names.find_key(result_label.text)):
			if player.inventory_has_item(ItemParser.names.find_key(result_label.text), 0):
				is_crafted = false
			else:
				await get_tree().create_timer(delay).timeout
				player.add_inventory_item(ItemParser.names.find_key(result_label.text), 1)
				is_crafted = true
		if is_crafted:
			if ingredient_label0.text:
				player.remove_inventory_item(ItemParser.names.find_key(ingredient_label0.text.left(-3)), ingredient_label0.text.right(-(ingredient_label0.text.length() - 1)).to_int())
			if ingredient_label1.text:
				player.remove_inventory_item(ItemParser.names.find_key(ingredient_label1.text.left(-3)), ingredient_label1.text.right(-(ingredient_label1.text.length() - 1)).to_int())
			if ingredient_label2.text:
				player.remove_inventory_item(ItemParser.names.find_key(ingredient_label2.text.left(-3)), ingredient_label2.text.right(-(ingredient_label2.text.length() - 1)).to_int())
			if ingredient_label3.text:
				player.remove_inventory_item(ItemParser.names.find_key(ingredient_label3.text.left(-3)), ingredient_label3.text.right(-(ingredient_label3.text.length() - 1)).to_int())
			if ingredient_label4.text:
				player.remove_inventory_item(ItemParser.names.find_key(ingredient_label4.text.left(-3)), ingredient_label4.text.right(-(ingredient_label4.text.length() - 1)).to_int())
			if ingredient_label5.text:
				player.remove_inventory_item(ItemParser.names.find_key(ingredient_label5.text.left(-3)), ingredient_label5.text.right(-(ingredient_label5.text.length() - 1)).to_int())


func player_has_item(label: Label) -> bool:
	if label.text != "":
		return player.inventory_has_item(ItemParser.names.find_key(label.text.left(-3)), label.text.right(-(label.text.length() - 1)).to_int())
	else:
		return true
