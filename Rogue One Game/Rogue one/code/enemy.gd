extends KinematicBody2D
class_name Enemy

signal dead

export var life := 5
export var degat := 1

var direction := Vector2.ZERO
var velocity := Vector2.ZERO
export var speed := 0.0
var initial_speed := 50.0
onready var  _heart = preload("res://prefabs/heart.tscn")


func _ready():
	var anims : Array = ["ghost", "snake", "slime" , "dead"]
	randomize()
	var rnd = randi()%3
	$AnimatedSprite.play(anims[rnd])
	direction = random_direction(Vector2.ZERO)



func random_direction(last_direction:Vector2) -> Vector2:
	var list = [Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2.DOWN, Vector2(1,1)]
	var tmp = list.duplicate()
	tmp.erase(last_direction)
	var rnd = randi()%tmp.size()
	return tmp[rnd]



func _process(delta):
	velocity = direction * speed * delta
	var collision = move_and_collide(velocity)
	if collision:
		direction = random_direction(direction)



func hit()-> void:
	life -= 1
	if life >0:
		$AnimatedSprite.modulate.a = 0.2
		yield(get_tree().create_timer(0.1), "timeout")
		$AnimatedSprite.modulate.a = 1.0
	else:
		$AnimatedSprite.play("dead")
		yield($AnimatedSprite, "animation_finished")
		emit_signal("dead")
		
		if randi()%5 <1:
			var heart = _heart.instance()
			get_parent().get_parent().add_child(heart)
			heart.global_position = self.global_position
		
		queue_free()

func _on_Timer_timeout():
	$Timer.wait_time = rand_range(1.5,3.0)
	speed = initial_speed + rand_range(-10 , 50)
	direction = random_direction(direction)
