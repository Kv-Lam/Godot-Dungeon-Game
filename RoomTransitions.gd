extends Node

var current_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	
	# The "_deferred" call waits until the previous room finishes executing all code before it 
	# begins freeing and transitioning to the next room (scene). 
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	# Frees the current scene.
	current_scene.free()
	# Loads the new, requested scene.
	var s = ResourceLoader.load(path)
	# Instances the new scene.
	current_scene = s.instantiate()
	# Add it to the current scene as child of the root node.
	get_tree().root.add_child(current_scene)
	# Optionally, to make it compatible the SceneTree.change_scene_to_file() API
	get_tree().current_scene = current_scene
