class_name FloatComponent
extends Node

# Export the sprite that this component will be scaling
@export var sprite: Node2D

# Export the float height (ex. 100 would be 100 units above and below the sprite)
@export var float_height = 3

# Export the time for a float cycle
@export var float_time := 0.1

var counter : int = 0
var is_floating = false


func start_float() -> void:
	is_floating = true

func _physics_process(_delta: float) -> void:
	# Manipulate the position of the node by the shake amount every physics frame
	# Use randf_range to pick a random x and y value using the shake value
	counter += 1
	if is_floating:
		sprite.position.y = float_height * sin(counter * float_time)
