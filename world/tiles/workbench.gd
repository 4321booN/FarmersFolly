extends StaticBody2D

@onready var sprite_workbench: Sprite2D = $Sprite2D
@onready var sprite_grass: Sprite2D = $Sprite2D2
@onready var control: Control = $Control
var toutching_mouse: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite_workbench.z_index = position.y
	sprite_grass.z_index = position.y - 100
	if toutching_mouse and Input.is_action_pressed("interact"):
		control.show()
	elif !toutching_mouse or Input.is_action_just_released("interact"):
		control.hide()


func _on_area_2d_mouse_entered():
	toutching_mouse


func _on_area_2d_mouse_exited():
	not toutching_mouse
