extends Control

var HP
var ATK
var DEF
var SPEED
#ADD WAY MORE STATS.


func update_health(progress_bar, max_HP):
	progress_bar.value = HP
	progress_bar.max_value = max_HP
	progress_bar.get_node("HP").text = "HP: %d/%d" % [HP, max_HP]


func set_stats(progress_bar, max_HP, ATK, DEF, SPEED, texture) -> void:
	var LVL_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/LVL as Label
	var MANA_STAMINA_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/MANA_STAMINA as Label
	
	var ATK_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/ATK as Label
	var DEF_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/DEF as Label
	var SPEED_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/SPEED as Label
	var texture_rect = $VBoxContainer/TextureRect as TextureRect

	self.HP = max_HP
	self.ATK = ATK
	self.DEF = DEF
	self.SPEED = SPEED

	update_health(progress_bar, max_HP)
	
	ATK_label.text = "ATK: %d" % ATK
	DEF_label.text = "DEF: %d" % DEF
	SPEED_label.text = "SPEED: %d" % SPEED
	texture_rect.texture = texture
	texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
