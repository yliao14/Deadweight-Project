extends Area2D

@export var platform_path: NodePath
var players_on_plate: Array = []

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("players"):
		if not players_on_plate.has(body):
			players_on_plate.append(body)
		var platform = get_node_or_null(platform_path)
		if platform:
			platform.start_moving()

func _on_body_exited(body):
	if body.is_in_group("players"):
		players_on_plate.erase(body)
		if players_on_plate.is_empty():
			var platform = get_node_or_null(platform_path)
			if platform:
				platform.returning()
