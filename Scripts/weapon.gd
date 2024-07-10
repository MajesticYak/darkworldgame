extends Node2D

#@export var bullet_speed = 1000
@export var fire_rate = 0.2
#@export var bullet_damage = 4.0
#@export var bullet_pierce = 1
#@export var bullet_amount = 4
#@export var blast_radius = 1
#@export var spread = 20

var can_fire = true

func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
		
	weapon_fire()

func weapon_fire():
	const BULLET = preload("res://Scenes/projectile.tscn") 
	if Input.is_action_pressed("attack") and can_fire:
		var bullet_instance = BULLET.instantiate()
		bullet_instance.global_position = %ShootingPoint.global_position
		bullet_instance.global_rotation = %ShootingPoint.global_rotation
		%ShootingPoint.add_child(bullet_instance)
		
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
