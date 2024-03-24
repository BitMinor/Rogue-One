extends Node2D

var posi_key := Vector2.ZERO

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$ui/ColorRect/count.text = "enemies count: " + str($count_enemy.get_child_count())
	posi_key = $key.global_position
	$key.global_position = Vector2(1000,-1000)
	var rectangle = $wall.get_used_rect()
	var cam = $player/Camera2D
	cam.limit_left = rectangle.position.x * rectangle.size.x
	cam.limit_top = rectangle.position.y * rectangle.size.y
	cam.limit_right = (rectangle.position.x + rectangle.size.x) * $wall.cell_size.x 
	cam.limit_bottom =(rectangle.position.y + rectangle.size.y) * $wall.cell_size.y 
	
	for any in $count_enemy.get_children():
		any.connect("dead",self,"enemy_dead")

func enemy_dead()->void:
	$ui/ColorRect/count.text = "enemies count: " +str($count_enemy.get_child_count() - 1)
	if $count_enemy.get_child_count() - 1 == 0:
		$key.global_position = posi_key
		$ui/ColorRect/count.text = "Find the key !"
