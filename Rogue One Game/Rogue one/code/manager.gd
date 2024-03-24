extends Node
signal change_life(value_life, value_max)
signal key1

export var default_life := 5
var life := 0
var level:= 0



func _ready():

	life = default_life
	load_data()


func changed_player_life(value:int) -> void:
	life += value 
	emit_signal("change_life",life, default_life)
	if life <= 0:
		get_tree().change_scene("res://UI/the_end.tscn")




func get_key1()->void:
	emit_signal("key1")


func is_player_full()-> bool:
	return life == default_life
	

func change_scene(value)->void:
	level = value
	save_data(level)
	var path = "res://levels/level_" + str(value) + ".tscn"
	var file := File.new()
	
	if file.file_exists(path):
		var _err = get_tree().change_scene(path)
	else:
		var r = get_tree().change_scene("res://UI/the_end.tscn")


func save_data(value:int):
	var file = File.new()
	file.open("user://save_rogue_template", File.WRITE)
	file.store_8(value)
	file.close()

func load_data()-> int:
	var file = File.new()
	if file.file_exists("user://save_rogue_template"):
		file.open("user://save_rogue_template", File.READ)
		var content = file.get_8()
		file.close()
		return content
	else:
		return 1



#func is_drop()-> bool:
#	return randi()%70 < 7

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
