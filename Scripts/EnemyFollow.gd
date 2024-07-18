extends State
class_name EnemyFollow

@onready var enemy = $"../.."
@export var move_speed := 100
@export var target : PhysicsBody2D

var current_path = []

func Enter():
	var current_path = []
	print("following")
	
func Update(_delta: float):
	if enemy.main_target and !target:
		var targ = enemy.find_nearest_target()
		if targ:
			target = targ
	if target:
		path_to_target(target.position)
	elif enemy.main_target:
		path_to_target(enemy.main_target.position)

func Physics_Update(_delta: float):
	if enemy.is_stunned:
		return
	if target and (target.global_position - enemy.global_position).length() <= enemy.attack_range:
		enemy.velocity = Vector2.ZERO
		$"../Attack".target = target
		Transitioned.emit(self, "Attack")
		return
	var targ
	if target:
		targ = target
	elif enemy.main_target:
		targ = enemy.main_target
	if targ and current_path.size() and ((targ.global_position - enemy.global_position).length() < 250 or targ == enemy.main_target):
		$"../../Attack".look_at(targ.global_position)
		var direction = enemy.global_position.direction_to(enemy.tile_map.map_to_local(current_path[0]))
		enemy.velocity = direction * enemy.speed
		if enemy.tile_map.local_to_map(enemy.global_position) == current_path[0]:
			current_path.pop_front()
	else:
		enemy.velocity = Vector2()
		Transitioned.emit(self, "Idle")
		return

func path_to_target(coord):
	var potential_targets = []
	var tile_size = enemy.tile_map.tile_set.tile_size.x
	var radius = floor(enemy.attack_range / tile_size)
	var x = enemy.tile_map.local_to_map(coord).x - radius
	var y = enemy.tile_map.local_to_map(coord).y - radius
	for i in range(2 * radius + 1):
		for j in range(2 * radius + 1):
			var new_coord = Vector2i(x + i, y + j)
			#if tile is not solid and distance between tile and target is less than enemy distance -> can 
			if !enemy.tile_map.astar_grid.is_point_solid(new_coord) and ((enemy.tile_map.map_to_local(new_coord) + Vector2(tile_size/2, tile_size/2)) - coord).length() < enemy.attack_range:
				potential_targets.append(new_coord)
	potential_targets.sort_custom(distance_sort)
	for i in potential_targets.size():
		var path = enemy.tile_map.astar_grid.get_id_path(
			enemy.tile_map.local_to_map(enemy.global_position),
			potential_targets[i]
		)
		path.pop_front()
		if path.size():
			current_path = path
		
		
func distance_sort(a, b):
	var dist_a = (enemy.tile_map.map_to_local(a) - enemy.global_position).length()
	var dist_b = (enemy.tile_map.map_to_local(b) - enemy.global_position).length()
	if dist_a < dist_b:
		return a
	return b
	
