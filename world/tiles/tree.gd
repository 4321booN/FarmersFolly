extends StaticBody2D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var player: CharacterBody2D = $"../../Player"
@onready var sprite = $TextureButton

var anim: int = 0
var grown: bool = false

func _process(_delta):
	if not anim_player.is_playing() and anim < 3:
		anim_player.play(str(anim))
		anim += 1
	if anim == 3:
		anim_player.play(str(anim))
		grown = true
	else:
		grown = false
		
	if player.position.y + 32 < position.y:
		sprite.z_index = 2
	else:
		sprite.z_index = 0



func _on_texture_button_pressed():
	if grown:
		player.add_inventory_item("stick", randi_range(3, 6))
		anim = 0
