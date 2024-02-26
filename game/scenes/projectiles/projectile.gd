class_name Projectile
extends RigidBody2D
## Player projectile

@export var speed: int = 5

func _physics_process(delta):
	var _velocity = Vector2(speed, 0)
	var _collision = move_and_collide(_velocity)
	if _collision:
		queue_free()
