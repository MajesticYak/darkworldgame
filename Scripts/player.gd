extends CharacterBody2D

@export var speed = 400  # speed in pixels/sec
@export var accel = 100

func _physics_process(_delta):
	var _mouse_position = get_global_mouse_position()
	var _mouse_direction : Vector2 = (get_global_mouse_position() - global_position).normalized()

	var direction = Input.get_vector("left", "right", "up", "down")
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	
	move_and_slide()
	
func take_damage():
	pass

