extends Area2D

var touched_by_p1 = false
var touched_by_p2 = false
var activated = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if activated:
		return

	if body.is_in_group("players"):
		if body.player_id == 1:
			touched_by_p1 = true
		elif body.player_id == 2:
			touched_by_p2 = true

		check_both_players()

func check_both_players():
	if touched_by_p1 and touched_by_p2 and not activated:
		activated = true
		move_players_to_level_2()

func move_players_to_level_2():
	var main = get_tree().current_scene

	var player1 = main.get_node_or_null("Player1")
	var player2 = main.get_node_or_null("Player2")
	var spawn1 = main.get_node_or_null("Level2SpawnP1")
	var spawn2 = main.get_node_or_null("Level2SpawnP2")

	if player1 and spawn1:
		player1.global_position = spawn1.global_position

	if player2 and spawn2:
		player2.global_position = spawn2.global_position

	if main.has_method("move_camera_to_level_2"):
		main.move_camera_to_level_2()

	print("Both players touched YellowRod. Move to Level 2.")
