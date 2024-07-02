extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 20.0

var move_direction : Vector2
var wander_time : float
var can_random = true

func randomize_wander():
	move_direction = Vector2(0,0)
	await get_tree().create_timer(randf_range(.5, 2)).timeout
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1,3)
	can_random = true
	
func Enter():
	randomize_wander()
	
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
		
	elif can_random:
		randomize_wander()
		can_random = false
	
func Physics_Update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed
