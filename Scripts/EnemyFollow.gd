extends State
class_name EnemyFollow

@export var enemy: CharacterBody2D
@export var move_speed := 60
@export var dynamic_target: CharacterBody2D
@export var static_target: Vector2

@onready var navigation_agent: NavigationAgent2D = $"../../Navigation/NavigationAgent2D"

var target_type = 0 #1 for dynamic, 2 for static

func Enter():
	if dynamic_target:
		target_type = 1
	elif static_target:
		target_type = 2
	print(target_type)
	
	
func Physics_Update(_delta: float):
	if navigation_agent.is_target_reachable() and navigation_agent.distance_to_target() < 200:
		var direction = Vector2()
		direction = (navigation_agent.get_next_path_position() - enemy.global_position).normalized()
		enemy.velocity = direction * move_speed
		match target_type:
			1:
				$"../../AttackArea".look_at(dynamic_target.position)
			2:
				$"../../AttackArea".look_at(static_target)
		if navigation_agent.distance_to_target() < 15:
			enemy.velocity = Vector2.ZERO
			Transitioned.emit(self, "Attack")
			
	else:
		enemy.velocity = Vector2()
		Transitioned.emit(self, "Idle")


func _on_timer_timeout():
	match target_type:
		1:
			navigation_agent.target_position = dynamic_target.global_position
		2:
			navigation_agent.target_position = static_target
