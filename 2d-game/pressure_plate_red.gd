extends Area2D

@export var linked_platform: NodePath
@export var is_upper_plate: bool = false  
@export var start_hidden: bool = false 
var players_on_plate: Array = []

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	if start_hidden:
		hide()
		$CollisionShape2D.set_deferred("disabled", true)

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
		return
	print("plate is_upper: ", is_upper_plate, " players: ", players_on_plate)
	var is_active = players_on_plate.size() > 0
	if is_upper_plate:
		platform.set_plate2(is_active)
	else:
		platform.set_plate1(is_active)
		
func reveal():
	show()
	$CollisionShape2D.set_deferred("disabled", false)
