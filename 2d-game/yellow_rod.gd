extends Area2D

var touched_by_p1 := false
var touched_by_p2 := false
var unlocked := false
var can_be_picked := false
var carried_by: Node = null
var players_in_range: Array = []

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	if carried_by == null:
		check_pickup_input()

func _on_body_entered(body):
	if body.is_in_group("players"):
		if not players_in_range.has(body):
			players_in_range.append(body)

		if body.player_id == 1:
			touched_by_p1 = true
		elif body.player_id == 2:
			touched_by_p2 = true

		check_unlock()

func _on_body_exited(body):
	if body.is_in_group("players"):
		players_in_range.erase(body)

func check_unlock():
	if touched_by_p1 and touched_by_p2 and not unlocked:
		unlocked = true
		can_be_picked = true
		print("Yellow rod unlocked!")

func check_pickup_input():
	if not can_be_picked:
		return

	for player in players_in_range:
		if Input.is_action_just_pressed(player.get_interact_action()):
			player.try_pick_item(self)
			break

func pick_up(player):
	carried_by = player
	can_be_picked = true
	monitoring = false
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)

func drop():
	if carried_by == null:
		return

	global_position = carried_by.global_position + Vector2(0, 12)
	carried_by = null
	monitoring = true
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
