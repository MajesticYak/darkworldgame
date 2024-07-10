extends Control

func _ready():
	#keyboard accessibility (enables keyboard input for menu keys)
	$startButton.grab_focus()

#changes to main scene
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

#changes to options scene
func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu_options.tscn")
	
#quits out of the game
func _on_quit_button_pressed():
	get_tree().quit()
