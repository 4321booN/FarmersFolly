extends Control

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
@onready var craft_button: Button = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer2/CraftButton
@onready var progress_label: Label = $ColorRect/HBoxContainer/VBoxContainer/HBoxContainer/ProgressLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer
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
			craft_button.disabled = true
			if delay > 0:
				progress_label.show()
				animation_player.play("crafting")
				await get_tree().create_timer(delay).timeout
				animation_player.stop()
				progress_label.hide()
			Inventory.add_inventory_item(ItemParser.names.find_key(result_label.text), 1)
			is_crafted = true
			craft_button.disabled = false
		elif ItemParser.is_item_tool(ItemParser.names.find_key(result_label.text)):
			if Inventory.inventory_has_item(ItemParser.names.find_key(result_label.text), 0):
				is_crafted = false
			else:
				await get_tree().create_timer(delay).timeout
				Inventory.add_inventory_item(ItemParser.names.find_key(result_label.text), 1)
				is_crafted = true
		if is_crafted:
			if ingredient_label0.text:
				Inventory.remove_inventory_item(ItemParser.names.find_key(ingredient_label0.text.left(-3)), ingredient_label0.text.right(-(ingredient_label0.text.length() - 1)).to_int())
			if ingredient_label1.text:
				Inventory.remove_inventory_item(ItemParser.names.find_key(ingredient_label1.text.left(-3)), ingredient_label1.text.right(-(ingredient_label1.text.length() - 1)).to_int())
			if ingredient_label2.text:
				Inventory.remove_inventory_item(ItemParser.names.find_key(ingredient_label2.text.left(-3)), ingredient_label2.text.right(-(ingredient_label2.text.length() - 1)).to_int())
			if ingredient_label3.text:
				Inventory.remove_inventory_item(ItemParser.names.find_key(ingredient_label3.text.left(-3)), ingredient_label3.text.right(-(ingredient_label3.text.length() - 1)).to_int())
			if ingredient_label4.text:
				Inventory.remove_inventory_item(ItemParser.names.find_key(ingredient_label4.text.left(-3)), ingredient_label4.text.right(-(ingredient_label4.text.length() - 1)).to_int())
			if ingredient_label5.text:
				Inventory.remove_inventory_item(ItemParser.names.find_key(ingredient_label5.text.left(-3)), ingredient_label5.text.right(-(ingredient_label5.text.length() - 1)).to_int())


func player_has_item(label: Label) -> bool:
	if label.text != "":
		return Inventory.inventory_has_item(ItemParser.names.find_key(label.text.left(-3)), label.text.right(-(label.text.length() - 1)).to_int())
	else:
		return true
