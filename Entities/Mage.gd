class_name Mage extends "res://Entities/Character.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = 60
	const speed = 30
	var attack = 30
	var defense = 10
	var dodge = 20
	var mana = 100
	var Ability = {0 : "Spell Flux", 3 : "Void Nova", 6 : "Inferno Grasp", 9 : "Final Incantation"}
	#Spell Flux - Calls down starlight to smite enemies or empower allies
	#Void Nova - Unleashes a burst of chaotic energy from the void
	#Inferno's Grasp - Summons a roaring flame to engulf enemies
	#Final Incantation - A last-ditch spell that consumes the Mage's reserves for massive damage


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
