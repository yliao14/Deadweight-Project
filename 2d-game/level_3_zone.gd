extends Area2D

var players_inside: Array = []

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("players"):
		if not players_inside.has(body):
			players_inside.append(body)

func _on_body_exited(body):
	if body.is_in_group("players"):
		players_inside.erase(body)
		reset_to_level2()

func reset_to_level2():
	var main = get_tree().current_scene
	var player1 = main.get_node_or_null("Player1")
	var player2 = main.get_node_or_null("Player2")
	var spawn1 = main.get_node_or_null("Level2SpawnP1")
	var spawn2 = main.get_node_or_null("Level2SpawnP2")
	
	if player1 and spawn1:
		player1.global_position = spawn1.global_position
		player1.velocity = Vector2.ZERO
	if player2 and spawn2:
		player2.global_position = spawn2.global_position
		player2.velocity = Vector2.ZERO
	
	
	var yellow_rod = main.get_node_or_null("Level2/YellowRod")
	if yellow_rod:
		yellow_rod.activated = false
		yellow_rod.touched_by_p1 = false
		yellow_rod.touched_by_p2 = false
	
	if main.has_method("move_camera_to_level_2"):
		main.move_camera_to_level_2()
	
	print("Player fell! Reset to Level 2.")
