extends Area2D



func _ready():
	var _err = MANAGER.connect("key1",self,"open_door")



func open_door()->void:
	$Sprite.visible = false
	$wall/CollisionPolygon2D.set_deferred("disabled", true)

func _on_exit_body_entered(body):
	if body.name == "player":
		MANAGER.change_scene(MANAGER.level+1)
