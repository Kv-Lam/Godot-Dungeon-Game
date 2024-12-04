extends Node
#Ranger
const texture = preload("res://Art/MinhBack.png")
var level = 1
var experience = 0
var health = 80
var max_health = 80
const speed = 50
var attack = 30
var defense = 20
const dodge = 60
var mana_stamina = 100
var has_mana = false
const Ability = {0 : "Flame Shot", 3 : "Piercing Gale", 6 : "Icy Bind", 9 : "Hail of Arrows"}
#Flame Shot - Shoots a burst of firey arrows
#Piercing Gale - Fires an arrow that travels through enemie's armor and defense
#Ice Bind - Freezes the Enemey causing them to lose a turn
#Hail of Arrows - Launches a flurry of whistling arrows to rain down

#func saveObject() -> Dictionary:
	#return {
		#"filepath": get_path(),
		#"level": level,
		#"health": health,
		#"max_health": max_health,
		#"attack": attack,
		#"defense": defense,
		#"mana_stamina": mana_stamina,
		#"has_mana": has_mana,
		#"position": self.global_position,
	#}
#
#
#func loadObject(data: Dictionary) -> void:
	#level = data.get("level", 1) #Restore the level, default to 1
	#health = data.get("health", 100)  # Restore health, default to 100 if missing
	#max_health = data.get("max_health", 100) #Restore max health, default to 100
	#attack = data.get("attack", 30) #Restore attack ability, default to 30
	#defense = data.get("defense", 30) #Restore defense ability, default to 30
	#mana_stamina = data.get("mana_stamina", 100) #Resotre mana stamina, default to 100
	#has_mana = data.get("has_mana", false) #Restore if they have mana, default to no
	#self.global_position = data.get("position", Vector2.ZERO)  # Restore position
