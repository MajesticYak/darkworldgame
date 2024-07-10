extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0
var health : float

func _ready():
	health = MAX_HEALTH

func take_damage(attack : Attack):
	health_changed.emit()
	health -= attack.attack_damage
	
	if owner.has_method("stun"):
		owner.stun(attack.stun_time)
		owner.velocity = (global_position - attack.attack_position).normalized() * attack.knockback_force
	
	if owner.has_method("flash"):
		owner.flash()
	
	if owner.has_method("tween_scale"):
		owner.tween_scale()
	
	if owner.has_method("tween_shake"):
		owner.tween_shake()
	
	if health <= 0:
		no_health.emit()
		owner.death()

# Create signals for health
signal health_changed() # Emit when the health value has changed
signal no_health() # Emit when there is no health left

