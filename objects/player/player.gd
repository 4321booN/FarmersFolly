extends CharacterBody2D


@onready var popup: Window = $"../Popup"
@onready var tilemap: TileMap = $"../TileMap"
@export var speed: float = 280
@export var dir: int = 0
@export var at_mouse_tile_id: int
var tile_pos: Vector2i
var breakables: Array = [2,3]
var interactables: Array = [1]
var nothing: Array = [-1, 0]
signal get_tile_data
signal change_tile


func _ready():
	pass


func _physics_process(_delta: float):
	tile_pos = Vector2i(get_global_mouse_position())
	emit_signal("get_tile_data", tile_pos)
	print(at_mouse_tile_id)

	move_and_slide()

	if dir > 3:
		dir = 3
	elif dir < 0:
		dir = 0

	if Input.is_action_pressed("walk_l"):
		velocity[0] = -speed
		dir = 3
	elif Input.is_action_pressed("walk_r"):
		velocity[0] = speed
		dir = 1
	else:
		velocity[0] = 0

	if Input.is_action_pressed("walk_u"):
		velocity[1] = -speed
		dir = 0
	elif Input.is_action_pressed("walk_d"):
		velocity[1] = speed
		dir = 2
	else:
		velocity[1] = 0

	if !(Input.is_action_pressed("walk_d") or Input.is_action_pressed("walk_u") or Input.is_action_pressed("walk_r") or Input.is_action_pressed("walk_l")):
		$PlayerSprite.play("idle")
	else:
		$PlayerSprite.play("walk_" + str(dir))

	if Input.is_action_pressed("attack"):
		print("attack action")
		for i in len(breakables):
			if at_mouse_tile_id == breakables[i]:
				emit_signal("change_tile", 0, Vector2i(0,0), 1)
				print("attack sucsessful")

	if Input.is_action_pressed("interact") and !popup.visible:
		print("interact action")
		for j in len(interactables):
			if at_mouse_tile_id == interactables[j]:
				popup.show()
				print("interaction sucsessful")
			else:
				print("interaction failed")
				for k in len(nothing):
					if at_mouse_tile_id == nothing[k]:
						emit_signal("change_tile", 0, Vector2i(1,1), 1)
						print("placement sucsessful")


func _on_world_area_at_mouse_tile_id(tile_id: int) -> void:
	at_mouse_tile_id = tile_id
