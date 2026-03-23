extends Node2D

@onready var camera = $Camera2D
@onready var cam_target_l1 = $CameraTarget_L1
@onready var cam_target_l2 = $CameraTarget_L2
@onready var cam_target_l3 = $CameraTarget_L3
@onready var congratulations_screen = $UI/CongratulationsScreen
@onready var game_over_screen = $UI/GameOverScreen
@onready var timer_label = $UI/TimerLabel
@onready var level3_warning = $UI/Level3Warning
@onready var hidden_platform_note = $UI/HiddenPlatformNote

@onready var zombie1 = $Zombie1
@onready var zombie2 = $Zombie2
@onready var zombie3 = $Zombie3
@onready var player1 = $Player1
@onready var player2 = $Player2

var current_target: Node2D
var total_time: float = 120.0
var timer_running: bool = false
var zombie_released: bool = false

func _ready():
	current_target = cam_target_l1
	camera.global_position = current_target.global_position
	game_over_screen.hide()
	congratulations_screen.hide()
	hidden_platform_note.hide()
	start_timer()
	

func _process(delta):
	camera.global_position = camera.global_position.lerp(current_target.global_position, 4.0 * delta)
	
	if timer_running:
		total_time -= delta
		update_timer_display()
		
		if total_time <= 10.0:
			timer_label.modulate = Color.RED
		
		if total_time <= 0.0:
			total_time = 0.0
			timer_running = false
			trigger_zombie_chase()

func update_timer_display():
	timer_label.text = str(int(ceil(total_time))) + "s"
	
func show_timer():
	timer_label.show()
	show_hidden_platform_note()

func start_timer():
	total_time = 120.0
	timer_running = true
	zombie_released = false
	timer_label.modulate = Color.WHITE
	update_timer_display()

func stop_timer():
	timer_running = false

func trigger_zombie_chase():
	if zombie_released:
		return
	zombie_released = true
	
	var target = get_closest_player()
	if target == null:
		return
	
	var base_x = target.global_position.x - 300
	var base_y = target.global_position.y
	
	
	zombie1.start_running(Vector2(base_x, base_y))
	zombie2.start_running(Vector2(base_x - 40, base_y))
	zombie3.start_running(Vector2(base_x - 80, base_y))

func get_closest_player() -> Node2D:
	if player1 == null and player2 == null:
		return null
	if player1 == null:
		return player2
	if player2 == null:
		return player1
	
	if player1.global_position.y >= player2.global_position.y:
		return player1
	else:
		return player2

func show_game_over():
	print("show_game_over called")
	game_over_screen.show()

func move_camera_to_level_2():
	current_target = cam_target_l2

func move_camera_to_level_3():
	current_target = cam_target_l3
	show_level3_warning()
	
func show_level3_warning():
	level3_warning.text = "If you fall from Level 3, you restart from Level 2."
	level3_warning.show()
	level3_warning.modulate.a = 1.0
	#fades out in 2s
	await get_tree().create_timer(2.0).timeout
	var tween = create_tween()
	tween.tween_property(level3_warning, "modulate:a", 0.0, 1.0)
	await tween.finished
	level3_warning.hide()

func show_congratulations():
	stop_timer()
	$BackgroundMusic.stop()
	$ZombieSound.stop()  
	congratulations_screen.show()
	
func show_hidden_platform_note():
	hidden_platform_note.show()
	hidden_platform_note.modulate.a = 1.0
	await get_tree().create_timer(3.0).timeout
	var tween = create_tween()
	tween.tween_property(hidden_platform_note, "modulate:a", 0.0, 1.0)
	await tween.finished
	hidden_platform_note.hide()
