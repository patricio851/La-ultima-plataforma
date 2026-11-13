
extends CharacterBody2D

# Movimiento
@export var SPEED: float = 300.0
@export var JUMP_VELOCITY: float = -400.0
@export var MAX_JUMPS: int = 3

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count: int = 0

# Referencia al personaje
@onready var ranji = $Ranji


func _physics_process(delta: float) -> void:

	# 1. Gravedad y saltos
	if is_on_floor():
		jump_count = 0
	else:
		velocity.y += gravity * delta

	# 2. Saltar
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1

	# 3. Movimiento horizontal
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		print("Velocidad actual: ", SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Girar a Ranji
	if direction > 0:
		ranji.flip_h = true
	elif direction < 0:
		ranji.flip_h = false

	# 5. Movimiento y colisiones
	move_and_slide()

	# 6. Animaciones
	if not is_on_floor():
		if velocity.y < 0:
			ranji.play("Jump")
		else:
			ranji.play("Fall")
	elif direction != 0:
		ranji.play("Left")
	else:
		ranji.play("Idle")
