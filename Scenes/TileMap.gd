extends TileMap

var astar_grid = AStarGrid2D

func _ready():
	astar_grid = AStarGrid2D.new()
	astar_grid.region = get_used_rect()
	astar_grid.cell_size = tile_set.tile_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	astar_grid.jumping_enabled = true
	astar_grid.update()

	var region_size = astar_grid.region.size
	var region_position = astar_grid.region.position
	
	for x in region_size.x:
		for y in region_size.y:
			var tile_position = Vector2i(
				x + region_position.x, 
				y + region_position.y
			)

			var tile_data = get_cell_tile_data(0, tile_position)
			
			#if !tile_data or tile_data.get_custom_data("wall"):
				#astar_grid.set_point_solid(tile_position)



func find_obj(coords):
	var children = get_children()
	for i in children.size():
		if local_to_map(children[i].global_position) == coords:
			return children[i]
