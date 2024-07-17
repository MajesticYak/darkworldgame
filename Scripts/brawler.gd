extends Enemy
class_name Brawler

@onready var attack_area = $Attack/Area2D

@onready var flash_component : FlashComponent = $FlashComponent as FlashComponent
@onready var scale_component : ScaleComponent = $ScaleComponent as ScaleComponent
@onready var shake_component : ShakeComponent = $ShakeComponent as ShakeComponent

func attack():
	$Attack/CPUParticles2D.emitting = true
	var hit_bodies = attack_area.get_overlapping_bodies()
	for i in hit_bodies.size():
		var curr_body = hit_bodies[i]
		if curr_body.is_in_group("Player") or curr_body.is_in_group("PlayerBuilt"):
			curr_body.take_damage()
	
func stun(stun_time):
	is_stunned = true
	await get_tree().create_timer(stun_time).timeout
	is_stunned = false

func flash():
	flash_component.flash()

func tween_scale():
	scale_component.tween_scale()

func tween_shake():
	shake_component.tween_shake()
