class_name FlashComponent
extends Node

# The flash component material
const FLASH_MATERIAL = preload("res://Effects/white_flash_material.tres")

# Export the sprite this compononet will be flashing
@export var sprite: CanvasItem

# Export a duration for the flash
@export var flash_duration: = 0.2

# Store the original sprite's material so it can reset after the flash
var original_sprite_material: Material

# Create a timer for the flash component to use
var timer: Timer = Timer.new()

func _ready() -> void:
	# We have to add the timer as a child of this component in order to use it
	add_child(timer)
	
	# Store the original sprite material
	original_sprite_material = sprite.material

func flash():
	# Set the sprite's material to the flash material
	sprite.material = FLASH_MATERIAL
	
	# Start the timer (passing in the flash duration)
	timer.start(flash_duration)
	
	# Wait until the timer times out
	await timer.timeout
	
	# Set the sprite's material back to the original material that we stored
	sprite.material = original_sprite_material
