extends Area2D



func _on_heart_body_entered(body):
	if body.name == "player" and not MANAGER.is_player_full():
		MANAGER.changed_player_life(1)
		queue_free()
