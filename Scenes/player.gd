extends CharacterBody2D

var speed = 400  # speed in pixels/sec

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed

	move_and_slide()
	
	#if Input.is_action_just_pressed("open options"):
		#implement this later so that player can access options in game
		#var optionsInstance = load("res://Scenes/menu_options.tscn").instantiate()
		#get_tree().current_scene.add_child(optionsInstance)
