class_name BaseScene extends Node

@onready var player: Node2D = $Player

#Checks to see if the scene_manager has an instance of the player.
#If so, then it creates a new player in the next scene and transfers the player data.
func _ready():
	if scene_manager.player:
		if player:
			player.queue_free()
			
		player = scene_manager.player
		add_child(player)
