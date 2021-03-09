extends enemy

var speed = 140
var friction = 100
var damage = 24
var repeated_damage = 1
var health = 20
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
onready var soft_collision = $SoftCollision

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = move_and_slide(knockback)
	velocity = position.direction_to(player.position) * speed
	if soft_collision.is_colliding():
		velocity += soft_collision.get_push_vector() * delta * 1000
	velocity = move_and_slide(velocity)

func _on_HitBox_area_entered(area):
	if "BulletArea" in area.name and !pause:
		knockback = area.knockback_vector * 150
		health -= Global.attack()
		if health < 1:
			Global.enemy_die(self)

func _on_HitBox_body_entered(body):
	if body.name == "Player" and !pause:
		Global.take_damage(damage)
		$Attack.start()

func _on_HitBox_body_exited(body):
	if body.name == "Player" and !pause:
		$Attack.stop()

func _on_Attack_timeout():
	Global.take_damage(repeated_damage)

