extends Node3D

@onready var mesh = get_node("Mesh")

var time = 0

func _process(delta):
	time += delta
	if time < 10:
		return

	time = 0
	var random_position = Vector3(
		randf_range(-5, 5),
		randf_range(-1, 1),
		randf_range(-5, 5)
	)

	var new_mesh = mesh.duplicate()
	new_mesh.position = random_position
	add_child(new_mesh)

	$ProtonScatter.rebuild.call_deferred()


func _physics_process(delta):
	if Input.is_anything_pressed():
		handle_camera_rotation_input(delta)


func handle_camera_rotation_input(delta):
	const CAMERA_ROTATION_SPEED = 50.0
	var rotate_horizontal := Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if rotate_horizontal != 0:
		var new_rotation = $CameraBase.rotation_degrees
		new_rotation.y += rotate_horizontal * delta * CAMERA_ROTATION_SPEED
		$CameraBase.rotation_degrees = new_rotation
