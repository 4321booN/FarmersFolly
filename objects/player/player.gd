extends CharacterBody2D


@export var speed: float = 140
@export var dir: int = 0

func _physics_process(delta: float):
	

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
