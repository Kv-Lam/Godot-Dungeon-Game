extends "res://Entities/Character.gd"


const texture = preload("res://Art/Fire_Wizard_Front.png")
var level = 1
var health = 60
var max_health = 60
const speed = 30
var attack = 30
var defense = 10
const dodge = 20
var mana_stamina = 100
var has_mana = true
const Ability = {0 : "Spell Flux", 3 : "Void Nova", 6 : "Inferno Grasp", 9 : "Final Incantation"}
#Spell Flux - Calls down starlight to smite enemies or empower allies
#Void Nova - Unleashes a burst of chaotic energy from the void
#Inferno's Grasp - Summons a roaring flame to engulf enemies
#Final Incantation - A last-ditch spell that consumes the Mage's reserves for massive damage
