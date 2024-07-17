extends StaticBody2D

@onready var flash_component : FlashComponent = $FlashComponent as FlashComponent
@onready var scale_component : ScaleComponent = $ScaleComponent as ScaleComponent
@onready var shake_component : ShakeComponent = $ShakeComponent as ShakeComponent
@onready var player : CharacterBody2D = get_tree().get_first_node_in_group("Player") as CharacterBody2D # Null if no parent
@onready var building_system : Node2D = player.building_system as Node2D

func flash():
	flash_component.flash()

func tween_scale():
	scale_component.tween_scale()

func tween_shake():
	shake_component.tween_shake()

func death(): # Make tilemap cell erased
	if building_system:
		building_system.tile_map.erase_cell(building_system.player_built_layer, building_system.tile_map.local_to_map(global_position))
	print("resource collected")
