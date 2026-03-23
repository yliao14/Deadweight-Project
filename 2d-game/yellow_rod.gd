extends Area2D

@export var target_level: int = 2

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
		move_players_to_next_level()

func move_players_to_next_level():
	var main = get_tree().current_scene
	var player1 = main.get_node_or_null("Player1")
	var player2 = main.get_node_or_null("Player2")
	var spawn1 = main.get_node_or_null("Level" + str(target_level) + "SpawnP1")
	var spawn2 = main.get_node_or_null("Level" + str(target_level) + "SpawnP2")
	print("spawn1: ", spawn1, " pos: ", spawn1.global_position if spawn1 else "null")
	print("spawn2: ", spawn2, " pos: ", spawn2.global_position if spawn2 else "null")
	print("player1: ", player1, " pos: ", player1.global_position if player1 else "null")
	print("player2: ", player2, " pos: ", player2.global_position if player2 else "null")
	if player1 and spawn1:
		player1.global_position = spawn1.global_position
		player1.velocity = Vector2.ZERO
	if player2 and spawn2:
		player2.global_position = spawn2.global_position
		player2.velocity = Vector2.ZERO
	var cam_method = "move_camera_to_level_" + str(target_level)
	if main.has_method(cam_method):
		main.call(cam_method)
