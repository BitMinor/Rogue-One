extends Area2D
var key_hold

func _on_key_body_entered(body):
	if body.name == "player":
		MANAGER.get_key1()
#		global_position =$player.global_position
		queue_free()
