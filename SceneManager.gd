class_name SceneManager extends Node

var player: Node2D
var scene_dir_path = "res://scenes/"
var current


#Takes the current scene, and the passed to_scene_name to send the player
#to the correct scene.
func change_scene(from, to_scene_name) -> void:
	player = from.player
	player.get_parent().remove_child(player)
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	# Calls the change_scene_to_file function and provides the path to the next file.
	# This is a deferred call so that it waits for all current scene processes to finish before executing the call.
	get_tree().call_deferred("change_scene_to_file", full_path)
	
	
	# Debug call to check if the current working scene is in fact the correct scene we wanted to switch to.
	# Used in conjunction with the lower also commented out function.
	#get_tree().connect("node_added", _on_scene_changed, ConnectFlags.CONNECT_ONE_SHOT)
	
# func below is for debugging to test if the new tree is in fact the next room we wanted to enter.
#func _on_scene_changed(new_node: Node) -> void:
	#if new_node == get_tree().current_scene:
		#print_debug(get_tree().current_scene)
	#else:
		#print("Scene has not changed?")
