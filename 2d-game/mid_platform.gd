extends StaticBody2D

@onready var collision = get_node_or_null("CollisionShape2D")

func _ready():
	hide_platform()

func show_platform():
	visible = true
	if collision:
		collision.set_deferred("disabled", false)
	print("MidPlatform shown")

func hide_platform():
	visible = false
	if collision:
		collision.set_deferred("disabled", true)
