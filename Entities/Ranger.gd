class_name Ranger extends "res://Entities/Character.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = 80
	const speed = 50
	var attack = 30
	var defense = 30
	var dodge = 60
	var stamina = 100
	var Ability = {0 : "Flame Shot", 3 : "Piercing Arrow", 6 : "Icy Shot", 9 : "Hail of Arrows"}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
