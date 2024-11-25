class_name Mage extends "res://Entities/Character.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = 60
	const speed = 30
	var attack = 30
	var defense = 10
	var dodge = 20
	var mana = 100
	var Ability = {0 : "Spell Flux", 3 : "a2", 6 : "a3", 9 : "a4"}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
