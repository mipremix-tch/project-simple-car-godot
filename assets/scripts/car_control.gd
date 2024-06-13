extends VehicleBody3D

var max_rpm = 500
var max_torque = 200

@onready var camera = $Camera
@onready var camera_3d = $Camera/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("car_turnright","car_turnleft") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("car_reverse","car_acceleration")
	var rpm = $WheelRL.get_rpm()
	$WheelRL.engine_force = acceleration * max_torque * ( 1 - rpm / max_rpm )
	rpm = $WheelRR.get_rpm()
	$WheelRR.engine_force = acceleration * max_torque * ( 1 - rpm / max_rpm )
	camera.global_position = camera.global_position.lerp(global_position, delta * 20.0)
	camera.transform = camera.transform.interpolate_with(transform, delta * 5.0)

