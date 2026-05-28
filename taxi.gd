extends CharacterBody3D


var current_speed = 0
var max_speed = 10
var reverse_speed = -2
var friction = 0.2
var acceleration = 0.4
var rotation_speed = 0.1


func _physics_process(delta: float) -> void:

	var throttle := Input.is_action_pressed("throttle")
	var brake := Input.is_action_pressed("brake")
	var forward: Vector3 = -global_transform.basis.z
	var steer: float = Input.get_axis("steer_right", "steer_left")
	
	if throttle:
		current_speed = move_toward(current_speed, max_speed, acceleration)
	elif brake:
		current_speed = move_toward(current_speed, reverse_speed, acceleration)
	else:
		current_speed = move_toward(current_speed, 0.0, friction)

	if abs(current_speed) > 0.01:
		var turn_amount = steer * rotation_speed * current_speed * delta
		rotate_y(turn_amount)
	
	velocity = forward * current_speed
	move_and_slide()
