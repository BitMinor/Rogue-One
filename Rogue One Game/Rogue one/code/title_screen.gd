extends Control

func _ready()->void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if MANAGER.load_data()>1:
		$VBoxContainer/btn_continue.disabled=false


func _on_btn_start_pressed():
	MANAGER.life = MANAGER.default_life
	MANAGER.change_scene(1)


func _on_btn_continue_pressed():
	MANAGER.life = MANAGER.default_life
	MANAGER.change_scene(MANAGER.load_data())


func _on_btn_exit_pressed():
	get_tree().quit()
