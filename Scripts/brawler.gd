extends CharacterBody2D
class_name Brawler

@onready var tile_map = $"../World/TileMap"
@onready var ray_cast = $AttackArea/RayCast2D

func _physics_process(_delta):
	if Input.is_action_just_pressed("exit"):
		attack()
	move_and_slide()
	
func attack():
	var hitTiles = []
	$AttackArea/CPUParticles2D.emitting = true
	for i in range(11):
		ray_cast.rotation = i * -.31
		await get_tree().create_timer(.02).timeout
		var hitBody = ray_cast.get_collider()
		if hitBody != null:
			if hitBody.is_in_group("Player"):
				#hitBody.takeDamage()
				pass
			elif hitBody is TileMap:
				var coords = tile_map.get_coords_for_body_rid(ray_cast.get_collider_rid())
				if hitTiles.find(coords) == -1:
					hitTiles.append(coords)
	for j in hitTiles.size():
		var coords = hitTiles[j]
		var atlas_coords = tile_map.get_cell_atlas_coords(0,coords,true)
		if atlas_coords != Vector2i(-1,-1): #if tile still exists
			if (atlas_coords.x - 1 == -1):
				tile_map.set_cell(0,coords,1,Vector2i(0,0))
			else:
				tile_map.set_cell(0,coords,0,atlas_coords - Vector2i(1,0))
