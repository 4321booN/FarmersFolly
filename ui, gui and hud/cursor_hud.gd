extends AnimatedSprite2D


@onready var player: CharacterBody2D = $"../Player"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	position = get_global_mouse_position() + Vector2(4,7)
	
	if position.distance_to(player.position) <= player.reach:
		play("true")
	else:
		play("false")
