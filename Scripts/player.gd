extends CharacterBody2D

var speed = 80  # speed in pixels/sec

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed

	move_and_slide()
	
func take_damage():
	pass
