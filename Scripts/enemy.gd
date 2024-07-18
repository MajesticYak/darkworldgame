extends CharacterBody2D
class_name Enemy

@onready var detection_area = $DetectionArea
@onready var tile_map = $"../TileMap"
@onready var ray_cast = $DetectionArea/RayCast2D

@onready var main_target : PhysicsBody2D = $"../Player" #if main target will attack in dir, otherwise when no objects sleep
@export var knockback_accel : int = 25

var is_stunned = false

func _physics_process(_delta):
	if is_stunned:
		velocity.x = move_toward(velocity.x, 0, knockback_accel)
		velocity.y = move_toward(velocity.y, 0, knockback_accel)
		move_and_slide()
		return
	move_and_slide()

func find_nearest_target():
	var nearby_bodies = detection_area.get_overlapping_bodies()
	var nearby_targets = []
	for i in nearby_bodies.size():
		var curr_body = nearby_bodies[i]
		if curr_body.is_in_group("Player") or curr_body.is_in_group("PlayerBuilt"):
			ray_cast.target_position = to_local(curr_body.position)
			ray_cast.force_raycast_update()
			if ray_cast.get_collider() == curr_body:
				nearby_targets.append(curr_body)
	if nearby_targets.size():
		nearby_targets.sort_custom(sort_distance)
		for j in nearby_targets.size():
			if nearby_targets[j].is_in_group("Player"):
				return nearby_targets[j]
		return nearby_targets[0]
	return null
	
func sort_distance(a,b):
	if (a.position - position).length() < (b.position - position).length():
		return true
	else:
		return false
