class_name enemy_template_target_button extends Control


func set_enemy_target_button_text(enemy_name: String) -> void:
	var button = $Button as Button
	button.text = enemy_name
	#button.size = Vector2(336, 77)
