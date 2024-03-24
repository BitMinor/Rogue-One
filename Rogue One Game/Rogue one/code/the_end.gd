extends Control


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	loop()
	if MANAGER.life<= 0:
		$ColorRect/VBox/Label.text = "You lose noob !"
	else:
		$ColorRect/VBox/btn_retry.visible = false
		$ColorRect/VBox/Label.text = "You win, just luck !"


func _on_btn_retry_pressed():
	MANAGER.life = MANAGER.default_life
	MANAGER.change_scene(MANAGER.level)


func _on_btn_exit_pressed():
	MANAGER.life = MANAGER.default_life
	var _err = get_tree().change_scene("res://UI/title_screen.tscn")

func loop()->void:
	var initial = $ColorRect/VBox/Label.modulate
	var next = Color(randi()%2,randi()%2,randi()%2,randi()%2)
	$tw.interpolate_property($ColorRect/VBox/Label,"modulate",initial,next,0.2, Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
	$tw.start()
	yield($tw,"tween_all_completed")
	loop()
