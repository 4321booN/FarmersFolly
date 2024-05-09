extends Control


@onready var player: CharacterBody2D = $"../../../../../../../../Player"
@onready var vboxcontainer: VBoxContainer = %VBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i: int in vboxcontainer.get_child_count():
		if i <= len(player.inventory) - 1:
			vboxcontainer.get_child(i).texture_rect.texture = ItemParser.textures[player.inventory[i].item]
			vboxcontainer.get_child(i).count_label.text = str(player.inventory[i].count)

