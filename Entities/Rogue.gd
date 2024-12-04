extends Node
#Rogue
#Kevin's variables.
const texture = preload("res://Art/KevinBack.png")
var experience = 0
var max_health = 50
var mana_stamina = 100
var has_mana = false

#Minh's variables.
var level = 1
var health = 50
const speed = 60
var attack = 30
var defense = 30
const dodge = 50
const Ability = {0 : "Backstab Blitz", 3 : "Phantom Strike", 6 : "Vortex of Blades", 9 : "Umbra Assassination"}
#Backstab Blitz - A devastating strike from the shadows
#Phantom Strike - A ghostly attack that strikes an enemy multiple times
#Vortex of Blades - Spins in a flurry of daggers damaging enemies
#Umbra Assassination - Strikes an enemy from complete stealth, instantly incapacitating them

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


#func loadObject(data: Dictionary) -> void:
	#level = data.get("level", 1) #Restore the level, default to 1
	#health = data.get("health", 100)  # Restore health, default to 100 if missing
	#max_health = data.get("max_health", 100) #Restore max health, default to 100
	#attack = data.get("attack", 30) #Restore attack ability, default to 30
	#defense = data.get("defense", 30) #Restore defense ability, default to 30
	#mana_stamina = data.get("mana_stamina", 100) #Resotre mana stamina, default to 100
	#has_mana = data.get("has_mana", false) #Restore if they have mana, default to no
	#self.global_position = data.get("position", Vector2.ZERO)  # Restore position
