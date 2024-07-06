extends State
class_name EnemyAttack

@export var target: CharacterBody2D
@onready var enemy = $"../.."

func Enter():
	enemy.attack()
	await get_tree().create_timer(.5).timeout
	Transitioned.emit(self, "Follow")
	


