extends Control


var HP
var ATK
var DEF
var SPEED


func update_health(max_HP):
	var progress_bar = get_node("VBoxContainer/HealthBar")
	progress_bar.value = HP
	progress_bar.get_node("HP").text = "HP: %d/%d" % [HP, max_HP]


func set_stats(max_HP, ATK, DEF, SPEED, texture) -> void:
	var ATK_label = $VBoxContainer/HBoxContainer/ATK as Label
	var DEF_label = $VBoxContainer/HBoxContainer/DEF as Label
	var SPEED_label = $VBoxContainer/HBoxContainer/SPEED as Label
	var texture_rect = $VBoxContainer/TextureRect as TextureRect
	var progress_bar = get_node("VBoxContainer/HealthBar")
	
	self.HP = max_HP
	self.ATK = ATK
	self.DEF = DEF
	self.SPEED = SPEED

	update_health(max_HP)
	progress_bar.max_value = max_HP
	ATK_label.text = "ATK: %d | " % ATK
	DEF_label.text = "DEF: %d | " % DEF
	SPEED_label.text = "SPEED: %d" % SPEED
	texture_rect.texture = texture
	texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
