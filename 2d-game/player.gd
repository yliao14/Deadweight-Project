extends CharacterBody2D

@export var player_id: int = 1
@export var speed: float = 220.0
@export var jump_force: float = -420.0
@export var gravity: float = 980.0

@onready var sprite = $AnimatedSprite2D

func _ready():
	add_to_group("players")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction := 0.0
	if player_id == 1:
		direction = Input.get_axis("p1_left", "p1_right")
		if Input.is_action_just_pressed("p1_jump") and is_on_floor():
			velocity.y = jump_force
	elif player_id == 2:
		direction = Input.get_axis("p2_left", "p2_right")
		if Input.is_action_just_pressed("p2_jump") and is_on_floor():
			velocity.y = jump_force
	
	velocity.x = direction * speed
	move_and_slide()
	
	
	update_animation(direction)
	
func update_animation(direction: float):
	if direction != 0:
		sprite.play("walk")
		sprite.flip_h = direction < 0
	else:
		sprite.play("idle")
