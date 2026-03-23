extends AnimatableBody2D

@export var move_speed: float = 150.0
@export var return_speed: float = 150.0
@export var move_distance: float = 300.0
@export var move_left: bool = true  

var start_position: Vector2
var direction: int = 0

func _ready():
	start_position = position

func _physics_process(delta):
	if direction == 0:
		return
	
	var left_bound = start_position.x - move_distance
	var right_bound = start_position.x + move_distance
	
	if direction == -1:
		position.x -= move_speed * delta
		if position.x <= start_position.x - move_distance:
			position.x = start_position.x - move_distance
			returning()
	
	elif direction == 1:
		position.x += move_speed * delta
		if position.x >= start_position.x + move_distance:
			position.x = start_position.x + move_distance
			returning()
	
	elif direction == 2:  
		position.x += return_speed * delta
		if position.x >= start_position.x:
			position.x = start_position.x
			direction = 0
	
	elif direction == -2:  
		position.x -= return_speed * delta
		if position.x <= start_position.x:
			position.x = start_position.x
			direction = 0

func start_moving():
	direction = -1 if move_left else 1

func returning():
	direction = 2 if move_left else -2
