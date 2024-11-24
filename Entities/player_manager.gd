extends Node


#var player_stats :   # Player's stats from Minh.
var player : CharacterBody2D = null  #The actual player body.

func _ready():
	#Only add the player body if the current scene should have it.
	if player == null and not is_in_excluded_scene():
		player = preload("res://Entities/player.tscn").instantiate()
		get_tree().current_scene.add_child(player)

#Function to check if the scene should have player body.
func is_in_excluded_scene() -> bool:
	var combat_scenes = ["Main Menu","Shop", "Fight", "Inventory"] #Scenes where player body should not be. Put root node name.
	return get_tree().current_scene.name in combat_scenes

#func save_stats():
	#var save_data = {
		#"health": player_stats.health,
		#"max_health": player_stats.max_health,
		#"attack": player_stats.attack,
		#"defense": player_stats.defense
	#}

func load_stats():
	#Load player stats from a saved file or other source.
	pass
	

func get_player_position() -> Vector2:
	if player != null:
		return player.global_position
	return Vector2.ZERO


func set_player(player):
	self.player = player


func get_player() -> Player:
	return player
