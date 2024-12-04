#extends BaseScene
extends Node

@onready var player: Node2D = $Player

#Checks to see if the scene_manager has an instance of the player.
#If so, then it frees the player from the queue, 
#creates a new player in the next scene and transfers the player data from the already existing player
#instance within the scene_manager.
func _ready():
	if scene_manager.player:
		if player:
			player.queue_free()
			
		player = scene_manager.player
		add_child(player)
