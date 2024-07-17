extends Node2D

@onready var ui : CanvasLayer = get_node("/root/Main/UI") as CanvasLayer
@onready var tile_map : TileMap = get_node("/root/Main/TileMap") as TileMap

var world_layer = 0
var player_built_layer = 1

var empty_tile_id = -1
var tile_id = 1

var is_building = false # Build mode (true/false)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(_event):
	if Input.is_action_just_pressed("build"): # Enter build mode
		is_building = not is_building
		ui.buttons_toggle_visibility()
	
	if Input.is_action_just_pressed("attack") and is_building: # Place tile
		var mouse_pos : Vector2 = get_global_mouse_position()
		
		var tile_mouse_pos : Vector2i = tile_map.local_to_map(mouse_pos)
		
		var source_id = 2
		
		var atlas_cord = Vector2i(0,0)
		
		if tile_map.get_cell_source_id(player_built_layer, tile_mouse_pos) == empty_tile_id:
			tile_map.set_cell(player_built_layer, tile_mouse_pos, source_id, atlas_cord, tile_id)
