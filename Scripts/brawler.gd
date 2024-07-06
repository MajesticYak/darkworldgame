extends CharacterBody2D
class_name Brawler

@onready var tile_map = $"../World/TileMap"
@onready var ray_cast = $AttackArea/RayCast2D

func _physics_process(_delta):
	if Input.is_action_just_pressed("exit"):
		attack()
	move_and_slide()
	
func attack():
	var hitBodies = []
	$AttackArea/CPUParticles2D.emitting = true
	for i in range(11):
		ray_cast.rotation = i * -.31
		await get_tree().create_timer(.02).timeout
		var hitBody = ray_cast.get_collider_rid()
		if (hitBodies.find(hitBody) == -1):
			hitBodies.append(hitBody)
	for i in range(hitBodies.size()):
		if instance_from_id(hitBodies[i].get_id()) is CharacterBody2D:
			#hitEnemies.takeDamage()
			pass
		else: #if this is not a characterbody, must be tilemap (prob maybe look in future)
			var coords = tile_map.get_coords_for_body_rid(hitBodies[i])
			var atlas_coords = tile_map.get_cell_atlas_coords(0,coords,true)
			if atlas_coords != Vector2i(-1,-1): #if tile still exists
				if (atlas_coords.x - 1 == -1):
					tile_map.set_cell(0,coords,1,Vector2i(0,0))
				else:
					tile_map.set_cell(0,coords,0,atlas_coords - Vector2i(1,0))
