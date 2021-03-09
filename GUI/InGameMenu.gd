extends CanvasLayer

func _ready():
	$Button.connect("pressed", self, "_quit")

func _process(delta):
	$HealthBar.max_value = Global.max_health
	$HealthBar.value = Global.health
	$Time.text = Global.format_time()

func _quit():
	get_tree().change_scene("res://GUI/Menu.tscn")
