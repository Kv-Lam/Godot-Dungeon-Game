extends Control


var MANA_STAMINA
var HP
var max_HP
var DEF


#Helper functions to use in combat.
func update_health(HP, max_HP):
	var progress_bar = get_node("VBoxContainer/HealthBar")
	progress_bar.value = HP
	progress_bar.max_value = max_HP
	progress_bar.get_node("HP").text = "HP: %d/%d" % [HP, max_HP]


func update_DEF(DEF):
	var DEF_label = get_node("VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/DEF")
	DEF_label.text = "DEF: %d | " % DEF


func update_MANA_STAMINA(MANA_STAMINA, MANA_OR_STAMINA: bool):
	var MANA_STAMINA_label = get_node("VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/MANA_STAMINA")
	if(MANA_OR_STAMINA): MANA_STAMINA_label.text = "MANA: %d" % MANA_STAMINA
	else: MANA_STAMINA_label.text = "STA: %d | " % MANA_STAMINA


func update_SPEED(SPEED):
	var SPEED_label = get_node("VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/SPEED")
	SPEED_label.text = "SPEED: %d" % SPEED


func update_ATK(ATK):
	var ATK_label = get_node("VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/ATK")
	ATK_label.text = "ATK: %d | " % ATK


#If MANA_OR_STAMINA = true, then mana. If false, then stamina.
func set_stats(LVL, MANA_STAMINA, MANA_OR_STAMINA: bool, DODGE, HP, max_HP, ATK, DEF, SPEED, texture) -> void:
	var LVL_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/LVL as Label
	var DODGE_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/DODGE as Label
	var texture_rect = $VBoxContainer/TextureRect as TextureRect
	var progress_bar = get_node("VBoxContainer/HealthBar")

	self.MANA_STAMINA = MANA_STAMINA
	self.HP = HP
	self.max_HP = max_HP
	self.DEF = DEF

	update_health(HP, max_HP)
	
	LVL_label.text = "LVL: %d | " % LVL
	update_MANA_STAMINA(MANA_STAMINA, MANA_OR_STAMINA)
	DODGE_label.text = "EVA: %d | " % DODGE
	update_ATK(ATK)
	update_DEF(DEF)
	update_SPEED(SPEED)
	texture_rect.texture = texture
	texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
