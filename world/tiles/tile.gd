extends StaticBody2D


@onready var player: CharacterBody2D = PlayerNode.player
@onready var sprite: Sprite2D = $Sprite2D


func _process(_delta: float) -> void:
	@warning_ignore("narrowing_conversion")
	z_index = position.y - player.position.y
