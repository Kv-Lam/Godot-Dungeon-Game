extends Control

@onready var turn_container = $ColorRect/HBoxContainer/ColorRect/TurnContainer as HBoxContainer
@onready var fight_button = $ColorRect/HBoxContainer/ColorRect/TurnContainer/Fight as Button
@onready var guard_button = $ColorRect/HBoxContainer/ColorRect/TurnContainer/Guard as Button
@onready var inventory_button = $ColorRect/HBoxContainer/ColorRect/TurnContainer/Inventory as Button
@onready var escape_button = $ColorRect/HBoxContainer/ColorRect/TurnContainer/Escape as Button
@onready var enemy_party_container = $ColorRect/EnemyPartyContainer as HBoxContainer
@onready var character_party_container = $ColorRect/PlayerPartyContainier as HBoxContainer
@onready var action_box = $ColorRect/HBoxContainer/ColorRect/VBoxContainer/ColorRect/ActionBox as RichTextLabel
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
var pressed_button: String = ""
var button_pressed: bool = false
var won: bool

# Called when the node enters the scene tree for the first time.
func wait_for_button_press() -> void:
	button_pressed = false  # Reset flag
	pressed_button = ""
	
	# Wait until any button is pressed
	while not button_pressed:
		await get_tree().create_timer(.1).timeout  # Yield until the next frame
	

# Connect signals (for each button)
func _ready():
	fight_button.connect("pressed", Callable(_on_button_pressed.bind("Fight")))
	guard_button.connect("pressed", Callable(_on_button_pressed.bind("Guard")))
	inventory_button.connect("pressed", Callable(_on_button_pressed.bind("Inventory")))
	escape_button.connect("pressed", Callable(_on_button_pressed.bind("Escape")))


#Button press handler.
func _on_button_pressed(button_name: String) -> void:
	button_pressed = true
	pressed_button = button_name


func fight() -> void:
	print("Fight.")


func guard() -> void:
	print("Guard.")


func open_inventory() -> void:
	print("Open Inventory.")


func escape() -> void:
	pass

func set_up_fight(collided_enemy: String) -> void:
	action_box.clear()
	randomize()
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
	while true:
		for entity in entities:
			if entity is enemy_template_for_fight:
				await get_tree().create_timer(1.0).timeout
				var target = randi() % PartyManager.party.size()
				var damage = max(entity["ATK"] - PartyManager.party[target].defense, 0)
				log_action(entity.enemy_name, "attacks the", PartyManager.party[target].name + " for " + str(damage) + "!")
				PartyManager.party[target].health -= damage
				#Update the HP Bar.
				for targeted in entities:
					if targeted["name"] == PartyManager.party[target].name:
						targeted["instance"].update_HP(PartyManager.party[target].health, PartyManager.party[target].max_health)
			else:
				var player_turn = true
				var current_player
				
				for player in PartyManager.party:
					if entity.name == player.name:
						current_player = player
				
				if(entity["instance"].guard):
					entity["instance"].guard = false
					current_player.defense = int(current_player.defense / 1.2)
					entity["instance"].update_DEF(current_player.defense)
				
				turn_container.visible = true
				log_action(entity["name"], "'s turn.")
				
				await wait_for_button_press()
				while player_turn:
					match pressed_button:
						"Fight":
							player_turn = false
							
						"Guard":
							player_turn = false
							entity["instance"].guard = true
							current_player.defense = int(current_player.defense * 1.2)
							entity["instance"].update_DEF(current_player.defense)
						"Inventory":
							log_action("Tried using inventory, but", "it is not implemented.")
							await wait_for_button_press()
						"Escape":
							player_turn = false
							if((randi() % 100) + (current_player.dodge / 10)) >= 50:
								won = false
								log_action("Successfully", "ran!")
								await get_tree().create_timer(1.0).timeout
								self.visible = false
								for instance in entities:
									if instance is enemy_template_for_fight:
										instance.queue_free()
									else:
										instance["instance"].queue_free()
								return
							else:
								log_action("Failed to", "run!")
				turn_container.visible = false


func log_action(entity_name: String, action: String, target: String = "", result: String = ""):
	#Create a formatted message.
	var action_message = "%s %s" % [entity_name, action]
	if target != "":
		action_message += " %s" % target
	if result != "":
		action_message += " (%s)" % result
	
	#Add the message to the action_box.
	action_box.append_text("[color=yellow]%s[/color]\n" % action_message)
	action_box.scroll_to_line(action_box.get_line_count() - 1)  #Auto-scroll to the latest message.
