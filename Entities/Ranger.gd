class_name Ranger extends "res://Entities/Character.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = 80
	const speed = 50
	var attack = 30
	var defense = 30
	var dodge = 60
	var stamina = 100
	var Ability = {0 : "Flame Shot", 3 : "Piercing Gale", 6 : "Icy Bind", 9 : "Hail of Arrows"}
	#Flame Shot - Shoots a burst of firey arrows
	#Piercing Gale - Fires an arrow that travels through enemie's armor and defense
	#Ice Bind - Freezes the Enemey causing them to lose a turn
	#Hail of Arrows - Launches a flurry of whistling arrows to rain down
	
