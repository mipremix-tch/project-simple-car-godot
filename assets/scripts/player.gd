extends CharacterBody3D

const SPEED = 5.0
const SENSITIVITY = 0.003
#const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var footstep = $footstep/StepSoundPlayer
@onready var head = $Head
@onready var cam = $Head/Camera3D

#func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#
#func _unhandled_input(event):
	#if event is InputEventMouseMotion:
		#head.rotate_y(-event.relative.x * SENSITIVITY)
		#cam.rotate_x(-event.relative.y * SENSITIVITY)
		#cam.rotation.x = clamp(cam.rotation.x, deg_to_rad(-40), deg_to_rad(60))

#func _play_footstep_audio():
	#footstep.pitch_scale = randf_range(.8, 1.2)
	#footstep.autoplay

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("fps_left", "fps_right", "fps_forward", "fps_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	# Play the sound while walking
	#if direction != Vector3():
		#_play_footstep_audio()
		#if $Timer.time_left <= 0:
				#step_sound_player.pitch_scale = randf_range(0.8, 1.2)
				#$Timer.start(0.2)

	move_and_slide()
