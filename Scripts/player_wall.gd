extends StaticBody2D
var health = 4
@onready var tile_map = $/root/Main/TileMap
var coords : Vector2i
var atlas_coords : Vector2i


func _ready():
	coords = tile_map.local_to_map(position)
	atlas_coords = tile_map.get_cell_atlas_coords(0, coords)
	tile_map.set_cell(0, coords, 1, atlas_coords, 1)
	
func take_damage():
	health = health - 1
	if health < 1:
		kill()
		return
	$Sprite2D.frame = health - 1
	
func kill():
	tile_map.erase_cell(1,coords)
	tile_map.set_cell(0, coords, 0, atlas_coords, 0)

