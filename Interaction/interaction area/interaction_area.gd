extends Area2D
#future note: update collision layer to only interact with the player
class_name InteractionArea

#the text shown above an object when near
@export var action_name: String = "interact"

#callable function is meant to be overrided;
#any object with an interaction area can override this function
#and provide its own implementation
var interact: Callable = func():
	pass

func _on_body_entered(body):
	InteractionManager.registerArea(self)


func _on_body_exited(body):
	InteractionManager.unregisterArea(self)
	
