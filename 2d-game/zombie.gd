extends Area2D

@export var run_speed: float = 150.0

var is_running: bool = false
var has_caught: bool = false

@onready var sprite = $AnimatedSprite2D

func _ready():
	hide()
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if has_caught:
		return
	if body.is_in_group("players"):
		has_caught = true
		is_running = false
		get_tree().current_scene.show_game_over()

func _process(delta):
	if not is_running or has_caught:
		return
	position.x += run_speed * delta

func start_running(spawn_position: Vector2):
	is_running = false
	has_caught = false
	global_position = spawn_position
	show()
	sprite.play("run")
	is_running = true
