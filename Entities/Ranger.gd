#Ranger
extends "res://Entities/Character.gd"


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
