extends State
class_name EnemyIdle

@export var enemy : CharacterBody2D
@export var move_speed := 20.0
@onready var ray_cast = $"../../Sweep"
@onready var tile_map = $".../.../.../World/TileMap"

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
	var target = await get_closest_body()
	if target:
		Transitioned.emit(self, "Follow")
		$"../Follow".target = target

func Physics_Update(_delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed

func get_closest_body(): #and visible
	var locatedTargets = []
	var targetDistance = []
	for i in range(41):
		ray_cast.rotation = i * .157
		await get_tree().create_timer(.5).timeout
		if ray_cast.is_colliding():
			var hitBody = ray_cast.get_collider_rid()
			if (locatedTargets.find(hitBody) == -1):
				locatedTargets.append(hitBody)
				targetDistance.append((ray_cast.get_collision_point() - enemy.position).length())
	if locatedTargets.size() != 0:
		var rid = locatedTargets[targetDistance.find(targetDistance.min())]
		var instance = instance_from_id(rid.get_id())
		if instance is CharacterBody2D:
			return instance.position
		elif instance is TileMap:
			return tile_map.map_to_local(tile_map.get_coords_for_body_rid(rid))
