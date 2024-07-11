extends State
class_name EnemyAttack

@onready var enemy = $"../.."
@export var target : PhysicsBody2D

func Enter():
	print("attacking")
	enemy.attack()
	await get_tree().create_timer(.75).timeout
	if !target: #if target was killed
		target = enemy.find_nearest_target()
		if !target: #no new target was found
			if enemy.main_target: #if main target exists
				$"../Follow".target = enemy.main_target
				Transitioned.emit(self, "Follow")
			else: #if there is no main target and no new target
				enemy.main_target = null
				Transitioned.emit(self, "Idle")
		else: #new target found
			$"../Follow".target = target
			Transitioned.emit(self, "Follow")
	else: #target still exists
		Transitioned.emit(self, "Follow")
	
	


