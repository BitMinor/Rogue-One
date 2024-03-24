extends KinematicBody2D

var velocity = Vector2.ZERO
export var speed := 600.0

func fire(position_player:Vector2, direction_player)-> void:
	velocity = direction_player * speed
	global_position = position_player

func _process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider is Enemy:
			collision.collider.hit()
		queue_free()
