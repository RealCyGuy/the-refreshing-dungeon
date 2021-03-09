extends Control

onready var start_button = $Start
const BUTTON_DOWN = preload("res://GUI/button_down.tres")
const BUTTON_UP = preload("res://GUI/button_up.tres")

func _ready():
	start_button.connect("button_down", self, "_on_start_button_down")
	start_button.connect("button_up", self, "_on_start_button_up")
	start_button.connect("pressed", self, "_on_start_button_pressed")

func _on_start_button_down():
	start_button.rect_position += Vector2(0, 4)
	start_button.add_stylebox_override("pressed", BUTTON_DOWN)
	start_button.add_stylebox_override("normal", BUTTON_DOWN)

func _on_start_button_up():
	start_button.rect_position -= Vector2(0, 4)
	start_button.add_stylebox_override("pressed", BUTTON_UP)
	start_button.add_stylebox_override("normal", BUTTON_UP)

func _on_start_button_pressed():
	Global.load_level(true)
