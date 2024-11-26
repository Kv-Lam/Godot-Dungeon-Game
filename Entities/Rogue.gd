class_name Rogue extends "res://Entities/Character.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = 50
	const speed = 60
	var attack = 30
	var defense = 30
	var dodge = 50
	var stamina = 100
	var Ability = {0 : "Backstab Blitz", 3 : "Phantom Strike", 6 : "Vortex of Blades", 9 : "Umbra Assassination"}
	#Backstab Blitz - A devastating strike from the shadows
	#Phantom Strike - A ghostly attack that strikes an enemy multiple times
	#Vortex of Blades - Spins in a flurry of daggers damaging enemies
	#Umbra Assassination - Strikes an enemy from complete stealth, instantly incapacitating them
	
