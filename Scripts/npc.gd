extends Node2D

func _ready():
	var interaction_area: InteractionArea = $InteractionArea
	interaction_area.interact = Callable(self, "npcInteract")

func npcInteract():
	print("hello")
