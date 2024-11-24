class_name SceneTrigger extends Area2D

@export var connected_scene: String #Name of the scene we are changing to.

func _on_body_entered(body):
	if body is Player:
		scene_manager.change_scene(get_owner(), connected_scene)