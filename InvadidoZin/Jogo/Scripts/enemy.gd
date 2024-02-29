extends CharacterBody2D


const SPEED = 1100.0
const JUMP_VELOCITY = -400.0

@onready var wall_detector = %RayCastJellyfish as RayCast2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedJellyfish
var direction = -1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_wall():
		direction *= -1
	velocity.x = direction * SPEED * delta

	move_and_slide()
	update_facing_direction()

func update_facing_direction():
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
