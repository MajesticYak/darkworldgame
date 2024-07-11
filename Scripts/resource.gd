extends StaticBody2D

@onready var flash_component : FlashComponent = $FlashComponent as FlashComponent
@onready var scale_component : ScaleComponent = $ScaleComponent as ScaleComponent
@onready var shake_component : ShakeComponent = $ShakeComponent as ShakeComponent

func flash():
	flash_component.flash()

func tween_scale():
	scale_component.tween_scale()

func tween_shake():
	shake_component.tween_shake()

func death():
	print("resource collected")
