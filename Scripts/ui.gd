extends CanvasLayer

@onready var player = $"../Player"
@onready var ui = $"."

@onready var fps_label = $FPSLabel
@onready var ammo_label = $AmmoLabel
@onready var reserve_ammo_label = $ReserveAmmoLabel

@onready var button = $Button
@onready var button_2 = $Button2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())
	ammo_label.text = "Ammo: " + str(player.weapon.current_ammo)
	reserve_ammo_label.text = "Reserve Ammo: " + str(player.weapon.reserve_ammo)

func buttons_toggle_visibility():
	button.visible = not button.visible
	button_2.visible = not button_2.visible

func _on_button_pressed():
	player.building_system.tile_id = 1


func _on_button_2_pressed():
	player.building_system.tile_id = 3
