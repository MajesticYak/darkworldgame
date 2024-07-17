extends Node2D

# Weapon properties
@export var fire_rate : float = 0.2

# Reload properties
@export var max_ammo : int
@onready var current_ammo : int = max_ammo
@export var reload_time : float = 0.4

# Bullet properties
@export var speed : float = 500
@export var max_range : float = 1200
@export var attack_damage : float = 1.0
@export var knockback_force : float = 250.0
@export var stun_time : float = 0.3

@onready var reload_timer : Timer = $ReloadTimer as Timer

var can_fire = true

func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	weapon_fire()

func weapon_fire():
	if not reload_timer.is_stopped():
		return
	
	if Input.is_action_pressed("attack") and can_fire:
		if current_ammo > 0:
			spawn_bullet()
		else:
			reload()
		
		can_fire = false
		await get_tree().create_timer(fire_rate).timeout
		can_fire = true
	
	if Input.is_action_pressed("reload") and current_ammo < max_ammo:
		reload()

func spawn_bullet():
	const BULLET = preload("res://Scenes/projectile.tscn") 
	var bullet_instance = BULLET.instantiate()
	
	current_ammo -= 1 # Take away 1 ammo
	
	bullet_instance.global_position = %ShootingPoint.global_position # Set bullet properties
	bullet_instance.global_rotation = %ShootingPoint.global_rotation
	bullet_instance.speed = speed
	bullet_instance.max_range = max_range
	bullet_instance.attack_damage = attack_damage
	bullet_instance.knockback_force = knockback_force
	bullet_instance.stun_time = stun_time
	
	%ShootingPoint.add_child(bullet_instance)

func reload():
	reload_timer.start(reload_time)

func refill_ammo():
	current_ammo = max_ammo

func _on_reload_timer_timeout():
	refill_ammo()
