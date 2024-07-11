extends Node

var player_scene = preload("res://Scenes/player.tscn")
var brawler_scene = preload("res://Scenes/brawler.tscn")
var wave_status = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var playerInstance = player_scene.instantiate()
	add_child(playerInstance)
	
