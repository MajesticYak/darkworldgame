extends State
class_name EnemyFollow

@onready var enemy = $"../.."
@export var move_speed := 100
@export var target : PhysicsBody2D

@onready var navigation_agent: NavigationAgent2D = $"../../Navigation/NavigationAgent2D"


func Enter():
	print("following")
	if target:
		navigation_agent.target_position = target.position
	else:
		if enemy.main_target:
			navigation_agent.target_position = enemy.main_target.position
	
func Physics_Update(_delta: float):
	if enemy.is_stunned:
		return
	if enemy.main_target and !target:
		var targ = enemy.find_nearest_target()
		if targ:
			target = targ
			navigation_agent.target_position = target.position
	if (navigation_agent.is_target_reachable() and navigation_agent.distance_to_target() < 200) or (!target and enemy.main_target):
		var direction = Vector2()
		direction = (navigation_agent.get_next_path_position() - enemy.global_position).normalized()
		enemy.velocity = direction * move_speed
		if target:
			$"../../Attack".look_at(target.position)
		else:
			$"../../Attack".look_at(enemy.main_target.position)
		if navigation_agent.distance_to_target() < enemy.attack_range:
			enemy.velocity = Vector2.ZERO
			$"../Attack".target = target
			Transitioned.emit(self, "Attack")
			
	else:
		enemy.velocity = Vector2()
		Transitioned.emit(self, "Idle")


func _on_timer_timeout():
	if target and is_instance_valid(target):
		navigation_agent.target_position = target.position
