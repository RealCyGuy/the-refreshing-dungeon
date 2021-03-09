extends KinematicBody2D

const SPEED = 300
var velocity = Vector2()

func _on_Lifetime_timeout():
	queue_free()
	
func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
		
func set_ball_direction(direction):
	look_at(get_global_mouse_position())
	$BulletArea.knockback_vector = direction
	velocity = direction * SPEED
