extends CharacterBody2D

# Variables configurables de movimiento
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var MAX_JUMPS = 3

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

# Referencias a los nodos
@onready var sprite = $Ranji
@onready var animation = $Ranji


func _physics_process(delta):

	# 1. Gravedad y reinicio de saltos
	if is_on_floor():
		jump_count = 0
	else:
		velocity.y += gravity * delta

	# 2. Sistema de salto y doble/triple salto
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or jump_count < MAX_JUMPS:
			velocity.y = JUMP_VELOCITY
			jump_count += 1

	# 3. Movimiento horizontal
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. Voltear el robot
	if direction > 0:
		sprite.flip_h = true
	elif direction < 0:
		sprite.flip_h = false

	# 5. Animaciones
	if direction > 0:
		animation.play("Left")
	elif direction < 0:
		animation.play("Left")
	else:
		animation.play("Idle")

	# 6. Procesar físicas
	move_and_slide()
