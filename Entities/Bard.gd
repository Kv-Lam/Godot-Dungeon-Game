extends "res://Entities/Character.gd"

# Called when the node enters the scene tree for the first time.
const texture = preload("res://Art/Fire_Wizard_Front.png")
var level = 1
var health = 100
var max_health = 100
const speed = 40
var attack = 20
var defense = 40
const dodge = 30
var mana_stamina = 100
var has_mana = true
const Ability = {0 : "Harmonic Resonance", 3 : "Cacophony Strike", 6 : "Rhapsody of Restoration", 9 : "Harmony's Embrace"}
#Harmonic Resonance - Use vibrations to shatter objects or disarm enemies
#Cacophony Strike - Releases a burst of sound energy that damages and disorients foes
#Rhapsody of Restoration - Heals and removes conditions from allies
#Harmony's Embrace - Shields opponent from all damage (ULT)
