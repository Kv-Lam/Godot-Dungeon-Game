extends Node


var saved_scene: String = ""
var defeated_enemy: Node2D
var current_enemy: Node = null  # Store the current enemy reference
var party: = [] #Holds what party members have been obtained.
var player_position: Vector2 = Vector2.ZERO

#func save_stats():
	#var save_data = {
		#"health": player_stats.health,
		#"max_health": player_stats.max_health,
		#"attack": player_stats.attack,
		#"defense": player_stats.defense
	#}


# Save the scene state before transitioning to combat
func save_current_scene(player: Node):
	saved_scene = get_tree().current_scene.get_path()  # Save the path of the current scene
	player_position = player.global_position  # Save player's position
		

# Load the scene state and remove defeated enemy.
func return_to_saved_scene():
	if saved_scene != "":
		var scene = load(saved_scene)
		get_tree().change_scene_to_file(scene)
		
		# Remove the defeated enemies
		if current_enemy:
			current_enemy.queue_free()
			current_enemy = null
		


#Call this after combat ends to return to the original scene.
func on_combat_end(win: bool) -> void:
	if(win): return_to_saved_scene()
	#else: Have to reset player position back to somewhere else, not free the enemy, and lose some gold I guess.
