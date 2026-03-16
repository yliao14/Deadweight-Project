extends Area2D

@export var mid_platform_path: NodePath
var players_inside: Array = []
var activated = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("players"):
		if not players_inside.has(body):
			players_inside.append(body)
		check_activation()

func _on_body_exited(body):
	if body.is_in_group("players"):
		players_inside.erase(body)

func check_activation():
	if activated:
		return

	if players_inside.size() >= 2:
		activated = true
		var mid_platform = get_node_or_null(mid_platform_path)
		if mid_platform and mid_platform.has_method("show_platform"):
			mid_platform.show_platform()
			print("Mid platform appeared!")
