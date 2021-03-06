extends KinematicBody2D

const BULLET = preload("res://Bullet/Bullet.tscn")

var speed = 150
var velocity = Vector2.ZERO
var time_since_last_shoot = 0

func _ready():
	Global.player = self

func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	time_since_last_shoot += delta
	if time_since_last_shoot > 14.0:
		speed = 300
	elif time_since_last_shoot > 8.0:
		speed = 250
	elif time_since_last_shoot > 4.0:
		speed = 200
	else:
		speed = 150
	get_input()
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("shoot"):
		if $AnimatedSprite.animation == "default" and (get_global_mouse_position() != global_position):
			$AnimatedSprite.play("fire")
			yield($AnimatedSprite, "animation_finished")
			$AnimatedSprite.stop()
			var current_bullets = Global.bullets
			while current_bullets > 0:
				current_bullets -= 1
				var direction = (get_global_mouse_position() - global_position).normalized()
				var bullet = BULLET.instance()
				get_parent().add_child(bullet)
				bullet.global_position = direction * 20 + global_position
				bullet.set_ball_direction(direction)
				$Shoot.play()
				yield(get_tree().create_timer(0.07), "timeout")
			$AnimatedSprite.play("default")
			time_since_last_shoot = 0
	
func _process(delta):
	look_at(get_global_mouse_position())
