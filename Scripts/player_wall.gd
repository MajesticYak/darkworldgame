extends StaticBody2D
var health = 4
@onready var tile_map = $/root/Main/World/TileMap

func _ready():
	tile_map.set_cell(0, tile_map.local_to_map(position), 1, Vector2(0,0), 1)
	
	
func take_damage():
	health = health - 1
	if health < 1:
		kill()
		return
	$Sprite2D.frame = health - 1
	
func kill():
	tile_map.erase_cell(1,tile_map.local_to_map(position))
	tile_map.set_cell(0, tile_map.local_to_map(position), 1, Vector2(0,0), 0)

