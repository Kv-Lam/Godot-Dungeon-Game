#Mage
extends "res://Entities/Character.gd"


const texture = preload("res://Art/DavidBack.png")
var level = 1
var experience = 0
var health = 60
var max_health = 60
const speed = 30
var attack = 30
var defense = 10
const dodge = 20
var mana_stamina = 100
var has_mana = true
const Ability = {0 : "Spell Flux", 3 : "Void Nova", 6 : "Inferno Grasp", 9 : "Final Incantation"}

func saveObject() -> Dictionary:
	return {
		"filepath": get_path(),
		"level": level,
		"health": health,
		"max_health": max_health,
		"attack": attack,
		"defense": defense,
		"mana_stamina": mana_stamina,
		"has_mana": has_mana,
		"position": self.global_position,
	}


func loadObject(data: Dictionary) -> void:
	level = data.get("level", 1) #Restore the level, default to 1
	health = data.get("health", 100)  # Restore health, default to 100 if missing
	max_health = data.get("max_health", 100) #Restore max health, default to 100
	attack = data.get("attack", 30) #Restore attack ability, default to 30
	defense = data.get("defense", 30) #Restore defense ability, default to 30
	mana_stamina = data.get("mana_stamina", 100) #Resotre mana stamina, default to 100
	has_mana = data.get("has_mana", false) #Restore if they have mana, default to no
	self.global_position = data.get("position", Vector2.ZERO)  # Restore position
#Spell Flux - Calls down starlight to smite enemies or empower allies
#Void Nova - Unleashes a burst of chaotic energy from the void
#Inferno's Grasp - Summons a roaring flame to engulf enemies
#Final Incantation - A last-ditch spell that consumes the Mage's reserves for massive damage
