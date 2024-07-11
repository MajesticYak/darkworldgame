extends Node2D

@onready var scale_component : ScaleComponent = $ScaleComponent as ScaleComponent
@onready var shake_component : ShakeComponent = $ShakeComponent as ShakeComponent
@onready var flash_component : FlashComponent = $FlashComponent as FlashComponent
@onready var float_component : FloatComponent = $FloatComponent as FloatComponent

func _ready():
	tween_scale()
	tween_shake()
	flash()
	start_float()
	var interaction_area: InteractionArea = $InteractionArea
	interaction_area.interact = Callable(self, "pickup")

func flash():
	flash_component.flash()

func tween_scale():
	scale_component.tween_scale()

func tween_shake():
	shake_component.tween_shake()

func start_float():
	float_component.start_float()

func pickup():
	print("+1 resource")
	queue_free()
