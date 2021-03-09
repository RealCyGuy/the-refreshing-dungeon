extends Control

var lapsed = 0
var animate_text = false
onready var text = $Text
onready var animation_player = $AnimationPlayer
onready var button = $Button
const BUTTON_DOWN = preload("res://GUI/button_down.tres")
const BUTTON_UP = preload("res://GUI/button_up.tres")

func _ready():
	text.text = (
		"Thank you for playing! You died "
		+ String(Global.deaths)
		+ " time"
		+ use_s(Global.deaths)
		+ ", killed "
		+ String(Global.dead_enemies.size())
		+ " enemies, and finished in "
		+ Global.format_time()
		+ "."
	)
	animation_player.connect("animation_finished", self, "_start_text")
	button.connect("button_down", self, "_on_button_down")
	button.connect("button_up", self, "_on_button_up")
	button.connect("pressed", self, "_on_button_pressed")
	
func _process(delta):
	if animate_text:
		lapsed += delta
	text.visible_characters = lapsed / 0.03

func _on_button_down():
	button.rect_position += Vector2(0, 4)
	button.add_stylebox_override("pressed", BUTTON_DOWN)
	button.add_stylebox_override("normal", BUTTON_DOWN)

func _on_button_up():
	button.rect_position -= Vector2(0, 4)
	button.add_stylebox_override("pressed", BUTTON_UP)
	button.add_stylebox_override("normal", BUTTON_UP)

func _on_button_pressed():
	get_tree().change_scene("res://GUI/Menu.tscn")

func _start_text(_anim_name):
	animate_text = true

func use_s(amount):
	return "" if amount == 1 else "s"
