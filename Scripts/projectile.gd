extends Area2D

# Weapon stats
var speed : float = 500
var max_range : float = 1200
var attack_damage : float = 1.0
var knockback_force : float = 250.0
var stun_time : float = 0.3

var travelled_distance = 0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
	travelled_distance += speed * delta
	
	if travelled_distance > max_range:
		queue_free()


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		attack.stun_time = stun_time
		
		hitbox.take_damage(attack)
		queue_free()


func _on_body_entered(_body):
	queue_free()
