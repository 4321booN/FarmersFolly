extends StaticBody2D


@onready var player: CharacterBody2D = $"../../Player"
@onready var sprite: Sprite2D = $Sprite2D


func _process(_delta: float) -> void:
	z_index = position.y - player.position.y
