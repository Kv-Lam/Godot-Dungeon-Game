#Rogue
extends "res://Entities/Character.gd"


const texture = preload("res://Art/KevinBack.png")
var level = 1
var experience = 0
var health = 50
var max_health = 50
const speed = 60
var attack = 30
var defense = 30
const dodge = 50
var mana_stamina = 100
var has_mana = false
const Ability = {0 : "Backstab Blitz", 3 : "Phantom Strike", 6 : "Vortex of Blades", 9 : "Umbra Assassination"}
#Backstab Blitz - A devastating strike from the shadows
#Phantom Strike - A ghostly attack that strikes an enemy multiple times
#Vortex of Blades - Spins in a flurry of daggers damaging enemies
#Umbra Assassination - Strikes an enemy from complete stealth, instantly incapacitating them
