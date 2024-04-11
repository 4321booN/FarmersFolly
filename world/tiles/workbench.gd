extends StaticBody2D


@onready var popup: Window = $WorkbenchPopup
@onready var control: Control = $WorkbenchPopup/Control
@onready var sprite_workbench: TextureButton = $Sprite2D
@onready var sprite_grass: Sprite2D = $Sprite2D2
@onready var player: CharacterBody2D = $"../../Player"
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
		"result" : "stone_pickaxe"
	}
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(_delta):
	@warning_ignore("narrowing_conversion")
	sprite_workbench.z_index = position.y
	@warning_ignore("narrowing_conversion")
	sprite_grass.z_index = position.y - 100


func _on_sprite_2d_pressed():
	popup.show()
	player.popup_open = true


func _on_button_pressed():
	popup.hide()
	player.popup_open = false
