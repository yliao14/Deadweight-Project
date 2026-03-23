extends Control

@onready var description = $Description
@onready var instruction = $Instruction
@onready var start_button = $StartButton
@onready var warning = $Warning
@onready var warning_sign = $WarningSign

func _ready():
	get_tree().paused = true
	start_button.hide()
	warning.hide()
	warning_sign.hide()
	instruction.hide()
	
	# descrption
	description.text = "The building is surrounded by zombies.\nTwo survivors must work together to reach\nthe rooftop and escape by helicopter\nbefore the horde breaks through..."
	description.modulate.a = 1.0
	
	start_button.pressed.connect(_on_start)
	
	# instruction after 8s
	await get_tree().create_timer(8.0).timeout
	await fade_out(description)
	description.hide()
	
	instruction.text = "Player 1: A / D to move  |  W to jump\nPlayer 2: ← / → to move  |  ↑ to jump\n"
	instruction.show()
	await fade_in(instruction)
	
	# warning after 10s
	await get_tree().create_timer(10.0).timeout
	await fade_out(instruction)
	instruction.hide()
	
	warning.show()
	warning_sign.show()
	warning.modulate.a = 0.0
	warning_sign.modulate.a = 0.0
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(warning, "modulate:a", 1.0, 0.5)
	tween.tween_property(warning_sign, "modulate:a", 1.0, 0.5)
	await tween.finished
	
	start_button.show()

func fade_out(node: Control):
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 0.0, 0.5)
	await tween.finished

func fade_in(node: Control):
	node.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(node, "modulate:a", 1.0, 0.5)
	await tween.finished

func _on_start():
	get_tree().paused = false
	hide()
	get_tree().current_scene.show_timer()
