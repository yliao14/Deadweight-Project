extends Control

func _ready():
	$RestartButton.pressed.connect(_on_restart)
	$QuitButton.pressed.connect(_on_quit)

func _on_restart():
	get_tree().reload_current_scene()

func _on_quit():
	get_tree().quit()
