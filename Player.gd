extends CharacterBody3D

#@export var player_index = 0
@export var controls: Resource = null

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_pressed(controls.jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir = Input.get_vector("right", "left", "backward", "forward") 
	var dx = Input.get_action_strength(controls.move_left) - Input.get_action_strength(controls.move_right)
	var dy = Input.get_action_strength(controls.move_backward) - Input.get_action_strength(controls.move_forward)
	var direction = (transform.basis * Vector3(dx, 0, dy)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
