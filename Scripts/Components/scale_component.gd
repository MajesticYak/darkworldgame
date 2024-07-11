class_name ScaleComponent
extends Node

# Export the sprite that this component will be scaling
@export var sprite: Node2D

# Export the scale amount (as a vector)
@export var scale_amount = Vector2(1.5, 1.5)

# Export the scale duration
@export var scale_duration: = 0.4


func tween_scale() -> void:
	# scale sprite using tween
	var tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	# scale the sprite from its current scale to the scale amount (in 1/10th of the scale duration)
	tween.tween_property(sprite, "scale", scale_amount, scale_duration * 0.1).from_current()
	# scale back to a value of 1 for the other 9/10ths of the scale duration
	tween.tween_property(sprite, "scale", Vector2.ONE, scale_duration * 0.9).from(scale_amount)
