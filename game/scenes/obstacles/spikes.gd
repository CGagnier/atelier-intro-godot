extends Area2D

signal died()

func _on_body_entered(body):
	if body is Player:
		died.emit()
