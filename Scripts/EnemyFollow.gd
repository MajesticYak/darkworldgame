extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 60
@export var target: CharacterBody2D

@onready var navigation_agent: NavigationAgent2D = $"../../Navigation/NavigationAgent2D"

func Enter():
	pass
	
func Physics_Update(_delta: float):
	if navigation_agent.is_target_reachable() and navigation_agent.distance_to_target() < 200:
		var direction = Vector2()
		direction = (navigation_agent.get_next_path_position() - enemy.global_position).normalized()
		enemy.velocity = direction * move_speed
		$"../../AttackArea".look_at(target.position)
		if navigation_agent.distance_to_target() < 15:
			enemy.velocity = Vector2.ZERO
			Transitioned.emit(self, "Attack")
			
	else:
		enemy.velocity = Vector2()
		Transitioned.emit(self, "Idle")


func _on_timer_timeout():
	if target:
		navigation_agent.target_position = target.global_position
