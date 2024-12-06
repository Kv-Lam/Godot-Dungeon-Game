class_name enemy_template_for_fight extends Control

var enemy_name: String
var enemy_instance_button: enemy_template_target_button
var HP
var max_HP
var ATK
var DEF
var SPEED


#Helper function to update HP Bar of enemy after they get attacked.
func update_HP():
	var health_bar = get_node("VBoxContainer/HealthBar")
	health_bar.value = HP
	health_bar.get_node("HP").text = "HP: %d/%d" % [HP, max_HP]

#Sets initial stats of enemy used for actual combat, setting their stat display, and setting the texture shown during combat.
func set_stats(enemy_name: String, max_HP, ATK, DEF, SPEED, texture, enemy_instance_button: enemy_template_target_button) -> void:
	var ATK_label = $VBoxContainer/HBoxContainer/ATK as Label
	var DEF_label = $VBoxContainer/HBoxContainer/DEF as Label
	var SPEED_label = $VBoxContainer/HBoxContainer/SPEED as Label
	var texture_rect = $VBoxContainer/TextureRect as TextureRect
	var health_bar = get_node("VBoxContainer/HealthBar")
	
	self.HP = max_HP
	self.max_HP = max_HP
	self.ATK = ATK
	self.DEF = DEF
	self.SPEED = SPEED
	self.enemy_name = enemy_name
	self.enemy_instance_button = enemy_instance_button

	update_HP()
	health_bar.max_value = max_HP
	ATK_label.text = "ATK: %d | " % ATK
	DEF_label.text = "DEF: %d | " % DEF
	SPEED_label.text = "SPEED: %d" % SPEED
	texture_rect.texture = texture
	texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
