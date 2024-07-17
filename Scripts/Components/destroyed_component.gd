class_name DestroyedComponent
extends Node

# Export the actor this component will operate on
@export var actor: Node2D

# Grab access to the health to tell when the health has reached zero
@export var health_component: HealthComponent

# Export and grab access to a spawner component so we can create an effect on death
@export var destroy_effect_spawner_component: SpawnerComponent

func _ready() -> void:
	# Connect the the no health signal on our stats to the destroy function
	health_component.no_health.connect(destroy)

func destroy() -> void:
	# create an effect (from the spawner component) and free the actor
	destroy_effect_spawner_component.spawn(actor.global_position)
	actor.queue_free() # Make use erase_cell for player_built objects
