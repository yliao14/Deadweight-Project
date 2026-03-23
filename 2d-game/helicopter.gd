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
		start_escape()

func start_escape():
	var main = get_tree().current_scene
	var player1 = main.get_node_or_null("Player1")
	var player2 = main.get_node_or_null("Player2")

	if player1:
		player1.set_physics_process(false)
	if player2:
		player2.set_physics_process(false)

	if main.has_method("move_camera_to_level_3"):
		main.move_camera_to_level_3()

	var tween = create_tween()
	tween.set_parallel(true)

	tween.tween_property(self, "global_position",
		global_position + Vector2(0, -800), 3.0).set_trans(Tween.TRANS_SINE)

	if player1:
		tween.tween_property(player1, "global_position",
			global_position + Vector2(-40, -800), 3.0).set_trans(Tween.TRANS_SINE)
	if player2:
		tween.tween_property(player2, "global_position",
			global_position + Vector2(40, -800), 3.0).set_trans(Tween.TRANS_SINE)

	tween.chain().tween_callback(show_end_screen)

func show_end_screen():
	print("show_end_screen called")
	var main = get_tree().current_scene
	print("main: ", main)
	print("has method: ", main.has_method("show_congratulations"))
	if main.has_method("show_congratulations"):
		main.show_congratulations()
