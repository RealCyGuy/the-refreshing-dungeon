extends Area2D

var entered = false
export(Array, NodePath) var spawn_names
var spawns = []

func _ready():
	connect("body_entered", self, "on_entered")
	for spawn_name in spawn_names:
		var spawn = get_node(spawn_name)
		spawn.connect("ready_for_hiding", self, "hide_node")

func hide_node(enemy_node):
	if !(enemy_node in spawns):
		spawns.append(enemy_node)
		enemy_node.visible = false
		enemy_node.pause = true
		enemy_node.set_physics_process(false)
		enemy_node.set_collision_mask_bit(0, false)

func on_entered(body):
	if body.name == "Player" and !entered:
		entered = true
		for spawn in spawns:
			if spawn:
				spawn.visible = true
				spawn.pause = false
				spawn.set_physics_process(true)
				spawn.set_collision_mask_bit(0, true)
