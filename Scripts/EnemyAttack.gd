extends State
class_name EnemyAttack

@onready var enemy = $"../.."

func Enter():
	enemy.attack()
	await get_tree().create_timer(.5).timeout
	Transitioned.emit(self, "Idle")
	


