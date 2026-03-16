extends Area2D

@export var linked_platform: NodePath
var players_on_plate: Array = []

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("players"):
		if not players_on_plate.has(body):
			players_on_plate.append(body)
		update_platform()

func _on_body_exited(body):
	if body.is_in_group("players"):
		players_on_plate.erase(body)
		update_platform()

func update_platform():
	var platform = get_node_or_null(linked_platform)
	if platform == null:
		print("platform not found")
		return

	if players_on_plate.size() > 0:
		platform.request_up()
	else:
		platform.release_request()
