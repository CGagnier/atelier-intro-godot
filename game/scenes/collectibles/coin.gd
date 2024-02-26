class_name Collectible
extends Area2D
## Collectible element

signal collected()

func _on_body_entered(body):
	collected.emit()
	if body is Projectile:
		body.queue_free()
	queue_free()
