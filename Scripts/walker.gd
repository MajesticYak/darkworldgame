extends CharacterBody2D

@export var speed : float  # speed in pixels/sec
@export var accel : float
@export var player : CharacterBody2D

@onready var flash_component : FlashComponent = $FlashComponent as FlashComponent
@onready var scale_component : ScaleComponent = $ScaleComponent as ScaleComponent
@onready var shake_component : ShakeComponent = $ShakeComponent as ShakeComponent

var is_stunned = false

func _physics_process(_delta):
	if is_stunned:
		velocity.x = move_toward(velocity.x, 0, accel)
		velocity.y = move_toward(velocity.y, 0, accel)
		move_and_slide()
		return
	
	var direction = global_position.direction_to(player.global_position)
	
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()

func stun(stun_time):
	is_stunned = true
	await get_tree().create_timer(stun_time).timeout
	is_stunned = false

func flash():
	flash_component.flash()

func tween_scale():
	scale_component.tween_scale()

func tween_shake():
	shake_component.tween_shake()

func death():
	queue_free()
