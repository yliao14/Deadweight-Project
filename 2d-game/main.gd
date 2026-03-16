extends Node2D

@onready var camera = $Camera2D
@onready var cam_target_l1 = $CameraTarget_L1
@onready var cam_target_l2 = $CameraTarget_L2

var current_target: Node2D

func _ready():
	current_target = cam_target_l1
	camera.global_position = current_target.global_position

func _process(delta):
	camera.global_position = camera.global_position.lerp(current_target.global_position, 4.0 * delta)

func move_camera_to_level_2():
	current_target = cam_target_l2
