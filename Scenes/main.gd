extends Node

var player_scene = preload("res://Scenes/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var playerInstance = player_scene.instantiate()
	add_child(playerInstance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
