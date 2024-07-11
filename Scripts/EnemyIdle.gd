extends State
class_name EnemyIdle

@onready var enemy = $"../.."

func Enter():
	print("idling")
	
func Update(_delta: float):
	var targ = enemy.find_nearest_target()
	if targ:
		$"../Follow".target = targ
		Transitioned.emit(self, "Follow")
	elif enemy.main_target:
		$"../Follow".target = null
		Transitioned.emit(self, "Follow")


func Physics_Update(_delta: float):
	pass


