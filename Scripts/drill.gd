extends StaticBody2D

@onready var drill_area : Area2D = $DrillArea
@onready var drill_timer : Timer = $DrillTimer

var is_mining = false


func _on_drill_area_area_entered(area):
	if area.name == "Node Area":
		is_mining = true
		drill_timer.start()


func _on_drill_timer_timeout():
	pass
