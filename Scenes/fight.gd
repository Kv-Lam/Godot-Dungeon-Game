extends Control


@onready var fight_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Fight as Button
@onready var guard_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Guard as Button
@onready var inventory_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Inventory as Button
@onready var escape_button = $ColorRect/HBoxContainer/ColorRect/BottomContainer/Escape as Button
@onready var enemy_party_container = $ColorRect/EnemyPartyContainer as HBoxContainer
@onready var character_party_container = $ColorRect/PlayerPartyContainier as HBoxContainer
const ENEMY_TEMPLATE_FOR_FIGHT = preload("res://Entities/enemy_template_for_fight.tscn")
const CHARACTER_TEMPLATE_FOR_FIGHT = preload("res://Entities/character_template_for_fight.tscn")


const enemy_data = [
		{
			"name": "Goblin",
			"texture": preload("res://icon.svg"),
			"HP": 100, "ATK": 50, "DEF": 2, "SPEED": 40
		},
		{
			"name": "Wolf",
			"texture": preload("res://Art/Fire_Wizard_Front.png"),
			"HP": 150, "ATK": 60, "DEF": 5, "SPEED": 50
		}
	]

const boss_data = { #Separate from the others to make it to where he can't randomly be put into the fight.
		"name": "Skeleton King", "texture": preload("res://Art/Main_Menu_Background.png"),
		"HP": 1000, "ATK": 25, "DEF": 10, "SPEED": 2
}

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
	#Add code to add the collided enemy in.
	var num_enemies = randi() % 5
	var enemy_instance = ENEMY_TEMPLATE_FOR_FIGHT.instantiate()
	
	if collided_enemy == boss_data["name"]:
		enemy_instance.set_stats(boss_data["name"], boss_data["HP"],
		boss_data["ATK"], boss_data["DEF"], boss_data["SPEED"], boss_data["texture"])
		enemy_party_container.add_child(enemy_instance)
	else:
		for enemy in enemy_data:
			if enemy["name"] == collided_enemy:
				enemy_instance.set_stats(enemy["name"], enemy["HP"], enemy["ATK"], enemy["DEF"], enemy["SPEED"], enemy["texture"])
				enemy_party_container.add_child(enemy_instance)
	entities.push_back(enemy_instance)
	
	for i in range(num_enemies): #Add 0-4 enemies to fight alongside the collided enemy.
		var enemy = enemy_data[randi() % enemy_data.size()]
		enemy_instance = ENEMY_TEMPLATE_FOR_FIGHT.instantiate()
		
		enemy_instance.set_stats(enemy["name"], enemy["HP"], enemy["ATK"], enemy["DEF"], enemy["SPEED"], enemy["texture"])
		
		entities.push_back(enemy_instance)
		enemy_party_container.add_child(enemy_instance)
		
	add_characters()
	
	entities.sort_custom(func(a, b): return a["SPEED"] > b["SPEED"]) #Sorts all the entities by speed.
	combat()

func add_characters() -> void:
	for character in PartyManager.party:
		var character_instance = CHARACTER_TEMPLATE_FOR_FIGHT.instantiate()
		character_instance.set_stats(character.level, character.mana_stamina, character.has_mana, character.dodge, 
		character.health, character.max_health, character.attack, character.defense, character.speed, character.texture)
		
		entities.push_back({"name": character.name, "SPEED": character.speed, "instance": character_instance})
		character_party_container.add_child(character_instance)


func combat() -> void:
	for entity in entities:
		#Add a timer to wait.
		if entity is enemy_template_for_fight:
			print(entity.enemy_name + " attacks!") #Put this into action menu somehow.
			var target = randi() % PartyManager.party.size()
			PartyManager.party[target].health -= (max(entity["ATK"] - PartyManager.party[target].defense, 0))
			#Update the HP Bar.
			for targetted in entities:
				if targetted["name"] == PartyManager.party[target].name:
					targetted["instance"].update_health(PartyManager.party[target].health, PartyManager.party[target].max_health)
			#Code for printing to action box.
		else:
			print(entity["name"])
