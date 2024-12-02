extends Control


@onready var fight_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Fight as Button
@onready var guard_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Guard as Button
@onready var inventory_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Inventory as Button
@onready var escape_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Escape as Button
@onready var enemy_party_container = $ColorRect/EnemyPartyContainer as HBoxContainer
@onready var player_party_containier = $ColorRect/PlayerPartyContainier as HBoxContainer
const ENEMY_TEMPLATE_FOR_FIGHT = preload("res://Entities/enemy_template_for_fight.tscn")
const CHARACTER_TEMPLATE_FOR_FIGHT = preload("res://Entities/character_template_for_fight.tscn")


var entities = []


# Called when the node enters the scene tree for the first time.
func _ready():
	fight_button.pressed.connect(fight)
	guard_button.pressed.connect(guard)
	inventory_button.pressed.connect(open_inventory)
	escape_button.pressed.connect(escape)

func fight() -> void:
	print("Fight.")


func guard() -> void:
	print("Guard.")


func open_inventory() -> void:
	print("Open Inventory.")


func escape() -> void:
	print("Escape.")
	entities.clear()


func set_up_fight(collided_enemy: String) -> void:
	const enemy_data = [
		{
			"name": "Goblin",
			"texture": preload("res://icon.svg"),
			"HP": 100, "max_HP": 100,
			"ATK": 4, "DEF": 2, "SPEED": 4
		},
		{
			"name": "Wolf",
			"texture": preload("res://Art/Fire_Wizard_Front.png"),
			"HP": 150, "max_HP": 150,
			"ATK": 10, "DEF": 5, "SPEED": 10
		}
	]
	
	const boss_data = { #Separate from the others to make it to where he can't randomly be put into the fight.
		"name": "Skeleton King", "texture": preload("res://Art/Main_Menu_Background.png"),
		"HP": 1000, "max_HP": 1000,
		"ATK": 25, "DEF": 10, "SPEED": 2
	}
	
	const player_data = {
		"name": "Mage", "texture": preload("res://Art/Fire_Wizard_Front.png"),
		
	}
	#Add code to add the collided enemy in.
	var num_enemies = randi() % 5
	var enemy_instance = ENEMY_TEMPLATE_FOR_FIGHT.instantiate()
	
	if collided_enemy == boss_data["name"]:
		enemy_instance.set_stats(enemy_instance.get_node("VBoxContainer/HealthBar"), boss_data["max_HP"],
		boss_data["ATK"], boss_data["DEF"], boss_data["SPEED"], boss_data["texture"])
		enemy_party_container.add_child(enemy_instance)
	else:
		for enemy in enemy_data:
			if enemy["name"] == collided_enemy:
				enemy_instance.set_stats(enemy_instance.get_node("VBoxContainer/HealthBar"),
				enemy["max_HP"], enemy["ATK"], enemy["DEF"], enemy["SPEED"], enemy["texture"])
				enemy_party_container.add_child(enemy_instance)
	entities.push_back(enemy_instance)
	
	for i in range(num_enemies): #Add 0-4 enemies to fight alongside the collided enemy.
		var enemy = enemy_data[randi() % enemy_data.size()]
		enemy_instance = ENEMY_TEMPLATE_FOR_FIGHT.instantiate()
		
		enemy_instance.set_stats(enemy_instance.get_node("VBoxContainer/HealthBar"),
		enemy["max_HP"], enemy["ATK"], enemy["DEF"], enemy["SPEED"], enemy["texture"])
		
		entities.push_back(enemy_instance)
		enemy_party_container.add_child(enemy_instance)
		
	
	entities.sort_custom(func(a, b): return a["SPEED"] > b["SPEED"]) #Sorts all the entities by speed.


func add_characters() -> void:
	for character in PartyManager.party:
		var character_instance = CHARACTER_TEMPLATE_FOR_FIGHT.instantiate()
		
