extends Control


var guard = false #When true, increase character's defense by 20% until their next turn.


#Helper functions to use in combat.
func update_HP(HP, max_HP): #Updates the HP bar above characters in fight.
	var HP_bar = get_node("VBoxContainer/HealthBar")
	HP_bar.value = HP
	HP_bar.get_node("HP").text = "HP: %d/%d" % [HP, max_HP]


func update_DEF(DEF): #Updates the number displayed by DEF in fight.
	var DEF_label = get_node("VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/DEF")
	DEF_label.text = "DEF: %d | " % DEF

#Updates mana/stamina bar. Never got used aside from my set_stats() because ability functionality was never 
#implemented by Minh, but will keep here for future.
func update_MANA_STAMINA(MANA_STAMINA, has_MANA: bool):
	var MANA_STAMINA_bar = get_node("VBoxContainer/ManaStaminaBar")
	if(has_MANA): MANA_STAMINA_bar.get_node("MANA_STAMINA").text = "MANA: %d" % MANA_STAMINA
	else: MANA_STAMINA_bar.get_node("MANA_STAMINA").text = "STA: %d" % MANA_STAMINA

#Updates the number that SPEED displays, but never got used outside set_stats() because items were never implemented.
func update_SPEED(SPEED):
	var SPEED_label = get_node("VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/SPEED")
	SPEED_label.text = "SPEED: %d" % SPEED

#Updates the number that ATK displays, but never got used outside set_stats() because items were never implemented by David.
func update_ATK(ATK):
	var ATK_label = get_node("VBoxContainer/StatContainer/VBoxContainer/HBoxContainer2/ATK")
	ATK_label.text = "ATK: %d | " % ATK

#Function calls helper functions above to set initial stats, sets the texture for the character, and uses STA or MANA bar.
#If MANA_OR_STAMINA = true, then mana. If false, then stamina.
func set_stats(LVL, MANA_STAMINA, has_MANA: bool, DODGE, HP, max_HP, ATK, DEF, SPEED, texture) -> void:
	var LVL_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/LVL as Label
	var DODGE_label = $VBoxContainer/StatContainer/VBoxContainer/HBoxContainer/DODGE as Label
	var texture_rect = $VBoxContainer/TextureRect as TextureRect
	var MANA_STAMINA_bar = get_node("VBoxContainer/ManaStaminaBar")
	var HP_bar = get_node("VBoxContainer/HealthBar")
	
	
	HP_bar.max_value = max_HP
	update_HP(HP, max_HP)
	
	LVL_label.text = "LVL: %d | " % LVL
	if not has_MANA: #Switches base mana bar to a yellow stamina bar style instead.
		var fill_stylebox = StyleBoxFlat.new()
		fill_stylebox.bg_color = Color(1, 1, 0)
		MANA_STAMINA_bar.add_theme_stylebox_override("fill", fill_stylebox)
	update_MANA_STAMINA(MANA_STAMINA, has_MANA)
	DODGE_label.text = "EVA: %d | " % DODGE
	update_ATK(ATK)
	update_DEF(DEF)
	update_SPEED(SPEED)
	texture_rect.texture = texture
	texture_rect.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
