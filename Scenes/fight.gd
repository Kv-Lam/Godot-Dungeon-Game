extends Control

@onready var turn_container = $ColorRect/HBoxContainer/ColorRect/TurnContainer as HBoxContainer
@onready var fight_button = $ColorRect/HBoxContainer/ColorRect/TurnContainer/Fight as Button
@onready var guard_button = $ColorRect/HBoxContainer/ColorRect/TurnContainer/Guard as Button
@onready var inventory_button = $ColorRect/HBoxContainer/ColorRect/TurnContainer/Inventory as Button
@onready var escape_button = $ColorRect/HBoxContainer/ColorRect/TurnContainer/Escape as Button
@onready var enemy_party_container = $ColorRect/EnemyPartyContainer as HBoxContainer
@onready var character_party_container = $ColorRect/PlayerPartyContainier as HBoxContainer
@onready var action_box = $ColorRect/HBoxContainer/ColorRect/VBoxContainer/ColorRect/ActionBox as RichTextLabel
@onready var target_enemy_container = $ColorRect/HBoxContainer/ColorRect/TargetEnemyContainer as HBoxContainer
const ENEMY_TEMPLATE_FOR_FIGHT = preload("res://Entities/enemy_template_for_fight.tscn")
const CHARACTER_TEMPLATE_FOR_FIGHT = preload("res://Entities/character_template_for_fight.tscn")
const ENEMY_TEMPLATE_TARGET_BUTTON = preload("res://Entities/enemy_template_target_button.tscn")
signal done #I learned about this too late... Could've used these for detecting a button press.

#Contains data of all non-boss enemies.
const enemy_data = [
		{
			"name": "Goblin",
			"texture": preload("res://Art/GoblinFront.png"),
			"HP": 50, "ATK": 45, "DEF": 2, "SPEED": 40
		},
		{
			"name": "Skeleton",
			"texture": preload("res://Art/SkeletonFront.png"),
			"HP": 100, "ATK": 50, "DEF": 5, "SPEED": 50
		}
	]

#Because there's only one boss, I did not use an array.
const boss_data = { #Separate from the others to make it to where he can't randomly be put into the fight.
		"name": "Skeleton King", "texture": preload("res://Art/SkeletonKingFront.png"),
		"HP": 300, "ATK": 50, "DEF": 10, "SPEED": 2
}

var entities = [] #Holds what all is in combat for sorting based on speed.
var pressed_button: String = "" #Holds what action button (fight, guard, inventory, or escape) player chose.
var button_pressed: bool = false #Used to check whether the player has done an action.
var enemy_button_pressed: bool = false #Used to check whether the player has selected which enemy to attack.
var enemy_instance_targeted: enemy_template_for_fight #Used to detect which enemy the player selected.
var won: bool

#Pauses combat's turns to wait for player action button input.
func wait_for_button_press() -> void:
	button_pressed = false  # Reset flag
	pressed_button = ""
	
	#Wait until any button is pressed.
	while not button_pressed:
		await get_tree().process_frame  #Wait until the next frame to check while again to prevent freeze.


#Connect each action button.
func _ready():
	fight_button.connect("pressed", Callable(_on_button_pressed.bind("Fight")))
	guard_button.connect("pressed", Callable(_on_button_pressed.bind("Guard")))
	inventory_button.connect("pressed", Callable(_on_button_pressed.bind("Inventory")))
	escape_button.connect("pressed", Callable(_on_button_pressed.bind("Escape")))


#Action button press handler.
func _on_button_pressed(button_name: String) -> void:
	button_pressed = true
	pressed_button = button_name

#Pauses combat's turns to wait for player enemy button selection input.
func wait_for_enemy_target_button_press() -> void:
	enemy_button_pressed = false  # Reset flag
	enemy_instance_targeted = null
	
	#Wait until an enemy is selected to attack.
	while not enemy_button_pressed:
		await get_tree().process_frame

#Enemy target button press handler.
func _on_enemy_target_button_pressed(enemy_instance) -> void:
	enemy_button_pressed = true
	enemy_instance_targeted = enemy_instance


#Creates the collided with enemy, random number of enemies (0-3), clears action box, creates the buttons that correspond to the
#enemies, calls add_characters(), and sorts array of all entities in the combat based on speed to allow for turn-based combat.
func set_up_fight(collided_enemy: String) -> void:
	action_box.clear() #Clears action box of text from other fights.
	randomize() #Makes randi() more random.
	var num_enemies #Number of random enemies to be added. 0-3.
	
	#Code below dynamically creates the enemies and connects their buttons.
	var enemy_instance = ENEMY_TEMPLATE_FOR_FIGHT.instantiate()
	var enemy_button_instance = ENEMY_TEMPLATE_TARGET_BUTTON.instantiate()
	enemy_button_instance.get_node("Button").connect("pressed", Callable(_on_enemy_target_button_pressed.bind(enemy_instance)))
	target_enemy_container.add_child(enemy_button_instance) #This is to keep the order of which the buttons were made so targeting isn't confusing graphically.
	
	if collided_enemy == boss_data["name"]: #Adds in ONLY the boss if collided with.
		num_enemies = 0
		enemy_instance.set_stats(boss_data["name"], boss_data["HP"],
		boss_data["ATK"], boss_data["DEF"], boss_data["SPEED"], boss_data["texture"], enemy_button_instance)
		enemy_button_instance.set_enemy_target_button_text(boss_data["name"])

	else: #Gets a random number between 0-3 for how many non-boss enemies should be added alongside the collided with non-boss enemy.
		num_enemies = randi() % 4
		for enemy in enemy_data:
			if enemy["name"] == collided_enemy:
				enemy_instance.set_stats(enemy["name"], enemy["HP"], enemy["ATK"], enemy["DEF"], enemy["SPEED"], enemy["texture"], enemy_button_instance)
				enemy_button_instance.set_enemy_target_button_text(enemy["name"])
	
	
	enemy_party_container.add_child(enemy_instance) #This is the container that actually holds the enemy templates displayed.
	entities.push_back(enemy_instance) 
	
	for i in range(num_enemies): #Add 0-3 enemies to fight alongside the collided enemy.
		var enemy = enemy_data[randi() % enemy_data.size()]
		enemy_instance = ENEMY_TEMPLATE_FOR_FIGHT.instantiate()
		enemy_button_instance = ENEMY_TEMPLATE_TARGET_BUTTON.instantiate()
		
		enemy_button_instance.set_enemy_target_button_text(enemy["name"])
		enemy_button_instance.get_node("Button").connect("pressed", Callable(_on_enemy_target_button_pressed.bind(enemy_instance)))
		target_enemy_container.add_child(enemy_button_instance)
		
		enemy_instance.set_stats(enemy["name"], enemy["HP"], enemy["ATK"], enemy["DEF"], enemy["SPEED"], enemy["texture"], enemy_button_instance)
		
		entities.push_back(enemy_instance)
		enemy_party_container.add_child(enemy_instance)
		

	add_characters()
	
	entities.sort_custom(func(a, b): return a["SPEED"] > b["SPEED"]) #Sorts all the entities by speed.
	
	combat() #Calls actual combat.
	await done
	done.emit()

#Dynamically creates the enemies.
func add_characters() -> void:
	for character in PartyManager.party:
		var character_instance = CHARACTER_TEMPLATE_FOR_FIGHT.instantiate()
		character_instance.set_stats(character.level, character.mana_stamina, character.has_mana, character.dodge, 
		character.health, character.max_health, character.attack, character.defense, character.speed, character.texture)
		
		entities.push_back({"name": character.name, "SPEED": character.speed, "instance": character_instance})
		character_party_container.add_child(character_instance) #Container that holds the character templates.

#The actual turn-based combat.
func combat() -> void:
	while true:
		for entity in entities: #Loops through all the entities involve in the combat for turn-based comat system.
			await get_tree().create_timer(1.5).timeout #To make the turns not go by so fast.
			if entity is enemy_template_for_fight:
				#Enemy attacks a random character.
				await get_tree().create_timer(1.5).timeout #Make enemy turns even slower since they don't have a human deciding what to attack.
				#Selects random character inside the party.
				var target_index = randi() % PartyManager.party.size()
				var target = PartyManager.party[target_index]
				var damage = max(entity["ATK"] - target.defense, 0) #Makes sure that the player can't just heal if their defense is high.
				log_action(entity.enemy_name, "attacks the", target.name + " for " + str(damage) + "!")
				target.health -= damage
				
				for targeted in entities: #Updates HP display of characters. Also checks for if enemy killed a character and whether party got wiped.
					if targeted["name"] == target.name: #For finding the character that the enemy hit. Updates their HP display.
						targeted["instance"].update_HP(target.health, target.max_health)
						if target.health <= 0: #Check for character death, remove if there is.
							targeted["instance"].queue_free() #Frees the character instance.
							entities.pop_at(entities.find(targeted)) #Removes the character from the fight.
							PartyManager.party.pop_at(target_index) #Removes the character from the actual party.
							if PartyManager.party.size() == 0: #If player's party got wiped, then delete all enemies and return.
								won = false
								self.visible = false #Hides fight.
								for enemy in entities:
									enemy.queue_free() #Deletes all enemies.
								entities.clear() #Resets entities for next fight.
								done.emit() #Tells set_up_fight that combat() finished.
								return
							break
			else:
				var player_turn = true #Used to ensure that the player's turn doesn't end until they actually do an action that ends it.
				var current_player #Holds which character's turn it is.
				
				#Find which character's turn it is.
				for player in PartyManager.party:
					if entity.name == player.name:
						current_player = player
				
				#If the character guarded their last turn, reset their DEF back to initial value.
				if(entity["instance"].guard):
					entity["instance"].guard = false
					current_player.defense = int(current_player.defense / 1.2)
					entity["instance"].update_DEF(current_player.defense)
				
				turn_container.visible = true #Makes action buttons visible.
				log_action(entity["name"] + "'s", "turn.")
				
				await wait_for_button_press()
				while player_turn:
					match pressed_button:
						"Fight":
							player_turn = false
							turn_container.visible = false #Hides the action buttons again.
							target_enemy_container.visible = true #Shows the buttons that let the player choose which enemy to attack.
							await wait_for_enemy_target_button_press() #Wait for player to choose which enemy to attack.
							target_enemy_container.visible = false #Hides the enemy selection buttons.
							var damage = max(current_player.attack - enemy_instance_targeted.DEF, 0)
							enemy_instance_targeted.HP -= damage
							log_action(current_player.name, "attacks", enemy_instance_targeted.enemy_name, "for " + str(damage) + '!')
							enemy_instance_targeted.update_HP() #Updates HP display of targeted enemy.
							if enemy_instance_targeted.HP <= 0: #Code for dealing with killing enemies.
								var index = 0 #Index for where the enemy is inside entities.
								for enemy in entities: #Finds where the enemy is inside entities. Frees target button and pops from entities.
									if enemy is enemy_template_for_fight:
										if enemy == enemy_instance_targeted:
											enemy_instance_targeted.enemy_instance_button.queue_free()
											entities.pop_at(index)
											break
									index += 1
								enemy_instance_targeted.queue_free() #Frees the actual enemy instance.
								if entities.size() == PartyManager.party.size(): #If there are no more enemies.
									won = true
									self.visible = false
									for character in entities:
										character["instance"].queue_free() #Frees all the characters from fight scene.
									entities.clear()
									done.emit()
									return
						"Guard": #Increases character's defense by 20% until their next turn.
							player_turn = false
							entity["instance"].guard = true
							var DEF_increase = int(current_player.defense * .2)
							current_player.defense += DEF_increase
							log_action(entity.name, "guards,", "raising their defense by", str(DEF_increase) + '!')
							entity["instance"].update_DEF(current_player.defense)
						"Inventory":
							log_action("Tried using inventory, but", "it is not implemented.")
							await wait_for_button_press()
						"Escape":
							player_turn = false
							if((randi() % 100) + (current_player.dodge / 10)) >= 50: #Successful escape.
								won = false
								log_action("Successfully", "ran!")
								await get_tree().create_timer(1.0).timeout #So the character can read that they successfully ran.
								self.hide()
								for instance in entities: #Frees everything left.
									if instance is enemy_template_for_fight: #Frees enemies.
										instance.enemy_instance_button.queue_free()
										instance.queue_free()
									else: #Frees characters.
										instance["instance"].queue_free()
								entities.clear()
								done.emit()
								return
							else:
								log_action("Failed to", "run!")
				turn_container.visible = false

#Helper function to print to the action box. Half the arguments were unnecessary, but I thought there would be items implemented.
func log_action(entity_name: String, action: String, target: String = "", result: String = ""):
	#Create a formatted message.
	var action_message = "%s %s" % [entity_name, action]
	if target != "":
		action_message += " %s" % target
	if result != "":
		action_message += " %s" % result
	
	#Add the message to the action_box.
	action_box.append_text("[color=yellow]%s[/color]\n" % action_message)
	action_box.scroll_to_line(action_box.get_line_count() - 1)  #Auto-scroll to the latest message.
