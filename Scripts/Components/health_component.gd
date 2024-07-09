extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0
var health : float

func _ready():
	health = MAX_HEALTH

func take_damage(attack : Attack):
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
		print("died")
		owner.death()
	
