extends Area2D

@export var mid_platform_path: NodePath
@export var floor2_zone_path: NodePath  # 新增，指向 Floor2Zone
var players_inside: Array = []

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("players"):
		if not players_inside.has(body):
			players_inside.append(body)
		check_hide()

func _on_body_exited(body):
	if body.is_in_group("players"):
		players_inside.erase(body)

func check_hide():
	if players_inside.size() >= 2:
		var mid_platform = get_node_or_null(mid_platform_path)
		if mid_platform and mid_platform.has_method("hide_platform"):
			mid_platform.hide_platform()
			print("Mid platform hidden!")
		var floor2_zone = get_node_or_null(floor2_zone_path)
		if floor2_zone:
			floor2_zone.reset()
