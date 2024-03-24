extends CanvasLayer

var paused = false

func _ready():
	
	$ColorRect/Sprite.visible = false
	$resum.visible = false
	var _err = MANAGER.connect("change_life", self, "recup_change_life" )
	MANAGER.connect("key1",self,"key_ui")
	$ColorRect/ProgressBar.max_value = MANAGER.default_life
	$ColorRect/ProgressBar.value = MANAGER.life



func _process(_delta):
	pass


func recup_change_life(value_life, value_max)->void:
	$ColorRect/ProgressBar.max_value = value_max
	$ColorRect/ProgressBar.value = value_life


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		take_pause()

func take_pause()->void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	paused = ! paused
	$resum.visible = paused
	get_tree().set_pause(paused)

func _on_btn_resume_pressed():
	take_pause()


func _on_btn_restart_pressed():
	take_pause()
	var _err = get_tree().reload_current_scene()


func _on_btn_exit_pressed():
	take_pause()
	var _err = get_tree().change_scene("res://UI/title_screen.tscn")


func key_ui()->void:
	$ColorRect/count.text = "Go to the door !"
	$ColorRect/Sprite.visible = true
