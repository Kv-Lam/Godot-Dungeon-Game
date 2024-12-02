extends Control


var MANA_STAMINA
var HP
var max_HP
var DEF


@onready var progress_bar = $VBoxContainer/HealthBar as ProgressBar
@onready var DEF_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/DEF as Label
@onready var MANA_STAMINA_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/MANA_STAMINA as Label
@onready var ATK_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/ATK as Label
@onready var SPEED_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/SPEED as Label

#Helper functions to use in combat.
func update_health(HP, max_HP):
	progress_bar.value = HP
	progress_bar.max_value = max_HP
	progress_bar.get_node("HP").text = "HP: %d/%d" % [HP, max_HP]


func update_DEF(DEF):
	DEF_label.text = "DEF: %d" % DEF


func update_MANA_STAMINA(MANA_STAMINA, MANA_OR_STAMINA: bool):
	if(MANA_OR_STAMINA): MANA_STAMINA_label.text = "STA: %d" % MANA_OR_STAMINA
	else: MANA_STAMINA_label.text = "MANA: %d" % MANA_OR_STAMINA


func update_SPEED(SPEED):
	SPEED_label.text = "SPEED: %d" % SPEED


func update_ATK(ATK):
	ATK_label.text = "ATK: %d" % ATK


#If MANA_OR_STAMINA = 1, then stamina. If 0, then mana.
func set_stats(LVL, MANA_STAMINA, MANA_OR_STAMINA: bool, DODGE, HP, max_HP, ATK, DEF, SPEED, texture) -> void:
	var LVL_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/LVL as Label
	var DODGE_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/DODGE as Label
	var texture_rect = $VBoxContainer/TextureRect as TextureRect

	self.MANA_STAMINA = MANA_STAMINA
	self.HP = HP
	self.max_HP = max_HP
	self.DEF = DEF

	update_health(HP, max_HP)
	
	LVL_label.text = "LVL: %d" % LVL
	update_MANA_STAMINA(MANA_STAMINA, MANA_OR_STAMINA)
	DODGE_label.text = "EVA: %d" % DODGE
	update_ATK(ATK)
	update_DEF(DEF)
	update_SPEED(SPEED)
	texture_rect.texture = texture
	texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
