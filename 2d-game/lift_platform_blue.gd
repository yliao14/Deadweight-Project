extends AnimatableBody2D

@export var rise_height: float = 180.0
@export var move_speed: float = 120.0

var start_pos: Vector2
var target_pos: Vector2
var active_request := false
var players_on_platform: Array = []

@onready var detect_area = $DetectArea

func _ready():
	start_pos = position
	target_pos = start_pos

	detect_area.body_entered.connect(_on_detect_body_entered)
	detect_area.body_exited.connect(_on_detect_body_exited)

func request_up():
	active_request = true
	target_pos = Vector2(start_pos.x, start_pos.y - rise_height)
	print("platform requested up")

func release_request():
	active_request = false
	print("platform released")

func _physics_process(delta):
	
	if not active_request and players_on_platform.is_empty():
		target_pos = start_pos
	elif active_request:
		target_pos = Vector2(start_pos.x, start_pos.y - rise_height)

	position = position.move_toward(target_pos, move_speed * delta)

func _on_detect_body_entered(body):
	if body.is_in_group("players"):
		if not players_on_platform.has(body):
			players_on_platform.append(body)

func _on_detect_body_exited(body):
	if body.is_in_group("players"):
		players_on_platform.erase(body)
