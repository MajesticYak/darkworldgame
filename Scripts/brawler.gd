extends Enemy
class_name Brawler

@onready var attack_area = $Attack/Area2D

func attack():
	$Attack/CPUParticles2D.emitting = true
	var hit_bodies = attack_area.get_overlapping_bodies()
	for i in hit_bodies.size():
		var curr_body = hit_bodies[i]
		if curr_body.is_in_group("Player") or curr_body.is_in_group("PlayerBuilt"):
			curr_body.take_damage()
	
