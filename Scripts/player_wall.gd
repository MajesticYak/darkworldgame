extends StaticBody2D
var health = 4
@onready var tile_map : TileMap = $/root/Main/TileMap
var coords : Vector2i


func _ready():
	coords = tile_map.local_to_map(position)
	tile_map.astar_grid.set_point_solid(coords)
	
	
func take_damage():
	health = health - 1
	if health < 1:
		kill()
		return
	$Sprite2D.frame = health - 1
	
func kill():
	tile_map.erase_cell(1,coords)
	tile_map.astar_grid.set_point_solid(coords, 0)
	queue_free()

