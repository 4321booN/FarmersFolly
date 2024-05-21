extends Control


@onready var player: CharacterBody2D = $"../../../../../../../../Player"
@onready var vboxcontainer: VBoxContainer = %VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	for i: int in vboxcontainer.get_child_count():
		for j: int in vboxcontainer.get_child_count():
			if vboxcontainer.get_child(i).texture_rect.texture == vboxcontainer.get_child(j).texture_rect.texture:
				vboxcontainer.get_child(i).texture_rect.texture = ResourceLoader.load("res://objects/item/null.png")
				vboxcontainer.get_child(i).count_label.text = ""
		if i <= len(player.inventory) - 1:
			vboxcontainer.get_child(i).texture_rect.texture = ItemParser.textures[player.inventory[i]["item"]]
			vboxcontainer.get_child(i).count_label.text = str(player.inventory[i]["count"])

