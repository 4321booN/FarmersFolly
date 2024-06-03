extends StaticBody2D


@onready var player: CharacterBody2D = $"../../Player"
@onready var sprite: Sprite2D = $Sprite2D


func _process(_delta: float) -> void:
	if player.position.y + 32 < position.y:
		sprite.z_index = 2
	else:
		sprite.z_index = 0

