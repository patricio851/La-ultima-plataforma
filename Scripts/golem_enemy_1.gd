extends CharacterBody2D

const GolemHWalk = 200
const Gravedad = 70
func _ready():
	velocity.x = -GolemHWalk
	$AnimatedSprite2D.play("Walk")
	
func _physics_process(delta):
	velocity.y += Gravedad
	
	if is_on_wall():
		if !$AnimatedSprite2D.flip_h:
			velocity.x = GolemHWalk
		else:
			velocity.x = -GolemHWalk
			
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = false
		elif velocity.x > 0:
			$AnimatedSprite2D.flip_h = true
		
	#hola hola probando
	
	
	move_and_slide()
