extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$back.grab_focus()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_start.tscn")
