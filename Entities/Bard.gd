class_name Bard extends "res://Entities/Character.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = 100
	const speed = 40
	var attack = 20
	var defense = 40
	var dodge = 30
	var mana = 100
	var Ability = {0 : "a1", 3 : "a2", 6 : "a3", 9 : "a4"}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
