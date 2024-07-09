extends Node2D
@onready var label = $Label

#base text for the label
const text = "E to " 

#holds all areas that can be interacted with
var active_areas = []
#can interact if player is in interaction area
var can_interact = true

#player is in the area, so it is interactable
func registerArea(area: InteractionArea):
	active_areas.push_back(area)

#player is no longer in that area, so it is no longer interactable
func unregisterArea(area: InteractionArea):
	var indexOfArea = active_areas.find(area)
	#if area parameter exists in array (area is currently registered)
	if (indexOfArea != -1):
		active_areas.remove_at(indexOfArea)
		
func _process(delta):
	#if player is in multiple interactable areas, choose the closest one to display
	if (active_areas.size() > 0 && can_interact):
		#custom sort compares two areas (a,b). If returns true, then array order is unchanged, otherwise swaps them
		#basically puts closest active area to the front of the array
		active_areas.sort_custom(sortByDistanceToPlayer)
		label.text = text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 90
		label.global_position.x -= label.size.x/2
		label.show()
	else:
		label.hide()
		
func sortByDistanceToPlayer(area1, area2):
	var player = get_tree().get_first_node_in_group("Player")
	var area1Distance = player.global_position.distance_to(area1.global_position)
	var area2Distance = player.global_position.distance_to(area2.global_position)
	return area1Distance < area2Distance
	
func _input(event):
	#if player can interact with an interactable area
	if (event.is_action_pressed("interact") && can_interact):
		if (active_areas.size() > 0):
			can_interact = false
			label.hide()
			
			#interact callable
			#will execute an objects interact function and then return back here after
			await active_areas[0].interact.call()
			can_interact = true
