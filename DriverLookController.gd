extends Node3D

@export var head_pivot: Node3D

@export var look_sensitivity: float = 0.12
@export var return_speed: float = 180.0

@export var min_yaw: float = -155.0
@export var max_yaw: float = 90.0

var yaw: float = 0.0
var is_looking: bool = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("look_mode"):
		is_looking = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if event.is_action_released("look_mode"):
		is_looking = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	var mouse_motion: InputEventMouseMotion = event as InputEventMouseMotion

	if is_looking and mouse_motion != null:
		yaw -= mouse_motion.relative.x * look_sensitivity
		yaw = clamp(yaw, min_yaw, max_yaw)


func _process(delta: float) -> void:
	if not is_looking:
		yaw = move_toward(yaw, 0.0, return_speed * delta)

	head_pivot.rotation_degrees.y = yaw
