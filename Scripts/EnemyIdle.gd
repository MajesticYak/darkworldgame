extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 20.0
@onready var tile_map = $/root/Main/World/TileMap
@onready var ray_cast = $"../../Sweep"

var dynamic_target : CharacterBody2D
var static_target : Vector2
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
	dynamic_target = null
	findTarget()
	randomize_wander()
	
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	elif can_random:
		randomize_wander()
		can_random = false
	if dynamic_target or static_target:
		$"../Follow".dynamic_target = dynamic_target
		$"../Follow".static_target = static_target
		Transitioned.emit(self, "Follow")

func Physics_Update(_delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed

func findTarget(): #and visible
	for i in range(41):
		ray_cast.rotation = i * .157
		await get_tree().create_timer(.01).timeout
		var hitBody = ray_cast.get_collider()
		if hitBody != null:
			if hitBody.is_in_group("Player"):
				dynamic_target = hitBody
				return
			elif hitBody is TileMap:
				var coords = tile_map.get_coords_for_body_rid(ray_cast.get_collider_rid())
				static_target = tile_map.map_to_local(coords)
				return
	findTarget()
