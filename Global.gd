extends Node

var bullets = 2
var damage = 2
var health = 75
var max_health = 100
var dead_enemies = []
var rng = RandomNumberGenerator.new()
var deaths = 0
var time = 0
var player

func _ready():
	rng.randomize()

func _process(delta):
	time += delta

func take_damage(dmg):
	var dmg_taken = rng.randi_range(dmg, dmg + 3)
	health -= dmg_taken
	if health < 1:
		deaths += 1
		load_level()
	get_tree().get_nodes_in_group("animation")[0].play("flash")
	return dmg_taken
	
func attack():
	if rng.randi_range(0, 10) < 3:
		return damage + 6
	else:
		return rng.randi_range(damage, damage + 2)
		
func enemy_die(enemy):
	dead_enemies.append(enemy.name)
	enemy.queue_free()
	
func load_level(new = false):
	call_deferred("_deferred_goto_scene", "res://World.tscn", new)

func _deferred_goto_scene(path, new):
	var root = get_tree().get_root()
	root.get_child(root.get_child_count() - 1).free()
	var s = ResourceLoader.load(path)
	var current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	if new:
		bullets = 2
		damage = 2
		max_health = 100
		dead_enemies = []
		deaths = 0
		time = 0
	health = max_health
	get_tree().call_group("enemies", "delete")

func end_game():
	get_tree().change_scene("res://GUI/GameOver.tscn")

func format_time():
	var mins = time / 60
	var secs = int(time) % 60
	var ms = int((time * 1000 / 10)) % 100
	
	return "%02d:%02d.%02d" % [mins, secs, ms]
