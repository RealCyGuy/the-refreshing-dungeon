extends Node2D

export(Vector2) var offset
onready var parent = get_parent()

func _ready():
	$TextureProgress.max_value = get_parent().health 
	set_as_toplevel(true)

func _process(delta):
	$TextureProgress.value = get_parent().health
	global_position = get_parent().global_position + offset
	global_rotation = 0
	if parent.visible:
		visible = true
	else:
		visible = false
