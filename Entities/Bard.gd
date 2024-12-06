extends Node
#Bard
# Called when the node enters the scene tree for the first time.
const texture = preload("res://Art/SeanBack.png")
var level = 1
var experience = 0
var health = 100
var max_health = 100
const speed = 40
var attack = 20
var defense = 40
const dodge = 30
var mana_stamina = 100
var has_mana = true
const Ability = {0 : "Harmonic Resonance", 3 : "Cacophony Strike", 6 : "Rhapsody of Restoration", 9 : "Harmony's Embrace"}

#Function to save individual stats and position during the game
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
#Loads all of the player stats and their position
#func loadObject(data: Dictionary) -> void:
	#level = data.get("level", 1) #Restore the level, default to 1
	#health = data.get("health", 100)  # Restore health, default to 100 if missing
	#max_health = data.get("max_health", 100) #Restore max health, default to 100
	#attack = data.get("attack", 30) #Restore attack ability, default to 30
	#defense = data.get("defense", 30) #Restore defense ability, default to 30
	#mana_stamina = data.get("mana_stamina", 100) #Resotre mana stamina, default to 100
	#has_mana = data.get("has_mana", false) #Restore if they have mana, default to no
	#self.global_position = data.get("position", Vector2.ZERO)  # Restore position
	#
	
#Harmonic Resonance - Use vibrations to shatter objects or disarm enemies
#Cacophony Strike - Releases a burst of sound energy that damages and disorients foes
#Rhapsody of Restoration - Heals and removes conditions from allies
#Harmony's Embrace - Shields opponent from all damage (ULT)
