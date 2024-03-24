extends KinematicBody2D

var direction:= Vector2.ZERO
var velocity := Vector2.ZERO
export var speed := 150.0
var action1:= false
var action2 := false
var is_cooldown := false


onready var _ball = preload("res://prefabs/ball.tscn")


func _ready() -> void:
	pass



func _process(_delta: float) -> void:
	input_loop()
	action_loop()
	animation_loop()
	velocity = move_and_slide(velocity)



func animation_loop() -> void:
	if direction == Vector2.ZERO:
		$AnimatedSprite.play("idle")
	elif direction.x != 0.0:
		$AnimatedSprite.play("right" if direction.x > 0 else "left")
	elif direction.y != 0.0:
		$AnimatedSprite.play("down" if direction.y > 0 else "up")



func action_loop() -> void:
	if action1:
		velocity= direction * (speed * 7)
	else:
		velocity = lerp(velocity, direction * speed, 0.15)
		
	if action2 and direction != Vector2.ZERO and not is_cooldown:
		is_cooldown = true
		var ball = _ball.instance()
		get_parent().add_child(ball)
		ball.fire(self.global_position, direction)
		yield(get_tree().create_timer(0.1), "timeout")
		is_cooldown = false

func input_loop() -> void:
	direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left") ,
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized()
	
	action1 = Input.is_action_just_pressed("action1")
	action2 = Input.is_action_pressed("action2")


func _on_hitbox_body_entered(body:Node):
	if body is Enemy and $god_mode.is_stopped():
		$god_mode.start()
		$AnimatedSprite.modulate.a = 0.4
		velocity =(body.global_position - self.global_position).normalized() * -500
		MANAGER.changed_player_life(-body.degat)

func _on_god_mode_timeout():
	$AnimatedSprite.modulate.a = 1.0
