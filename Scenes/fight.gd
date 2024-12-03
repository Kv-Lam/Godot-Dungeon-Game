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
const ENEMY_TEMPLATE_TARGET_BUTTON = preload("res://enemy_template_target_button.tscn")
signal done #I learned about this too late... Could've used these for detecting a button press.

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

const boss_data = { #Separate from the others to make it to where he can't randomly be put into the fight.
		"name": "Skeleton King", "texture": preload("res://Art/SkeletonKingFront.png"),
		"HP": 300, "ATK": 50, "DEF": 10, "SPEED": 2
}

var entities = []
var pressed_button: String = ""
var button_pressed: bool = false
var enemy_button_pressed: bool = false
var enemy_instance_targeted: enemy_template_for_fight
var won: bool

# Called when the node enters the scene tree for the first time.
func wait_for_button_press() -> void:
	button_pressed = false  # Reset flag
	pressed_button = ""
	
	# Wait until any button is pressed
	while not button_pressed:
		await get_tree().process_frame  # Yield until the next frame


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


func wait_for_enemy_target_button_press() -> void:
	enemy_button_pressed = false  # Reset flag
	enemy_instance_targeted = null
	
	# Wait until any button is pressed
	while not enemy_button_pressed:
		await get_tree().process_frame  # Yield until the next frame


func _on_enemy_target_button_pressed(enemy_instance) -> void:
	enemy_button_pressed = true
	enemy_instance_targeted = enemy_instance

func set_up_fight(collided_enemy: String) -> void:
	action_box.clear()
	randomize()
	#Add code to add the collided enemy in.
	var num_enemies
	var enemy_instance = ENEMY_TEMPLATE_FOR_FIGHT.instantiate()
	var enemy_button_instance = ENEMY_TEMPLATE_TARGET_BUTTON.instantiate()
	
	enemy_button_instance.get_node("Button").connect("pressed", Callable(_on_enemy_target_button_pressed.bind(enemy_instance)))
	target_enemy_container.add_child(enemy_button_instance)
	
	if collided_enemy == boss_data["name"]:
		num_enemies = 0
		enemy_instance.set_stats(boss_data["name"], boss_data["HP"],
		boss_data["ATK"], boss_data["DEF"], boss_data["SPEED"], boss_data["texture"], enemy_button_instance)
		enemy_button_instance.set_enemy_target_button_text(boss_data["name"])

	else:
		num_enemies = randi() % 4
		for enemy in enemy_data:
			if enemy["name"] == collided_enemy:
				enemy_instance.set_stats(enemy["name"], enemy["HP"], enemy["ATK"], enemy["DEF"], enemy["SPEED"], enemy["texture"], enemy_button_instance)
				enemy_button_instance.set_enemy_target_button_text(enemy["name"])
		
	enemy_party_container.add_child(enemy_instance)
	entities.push_back(enemy_instance)
	
	for i in range(num_enemies): #Add 0-4 enemies to fight alongside the collided enemy.
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
	
	combat()
	await done
	done.emit()


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
			await get_tree().create_timer(1.5).timeout
			if entity is enemy_template_for_fight:
				#Enemy attacks a random character.
				await get_tree().create_timer(1.5).timeout
				var target_index = randi() % PartyManager.party.size()
				var target = PartyManager.party[target_index]
				var damage = max(entity["ATK"] - target.defense, 0) #Fix up damage calculation.
				log_action(entity.enemy_name, "attacks the", target.name + " for " + str(damage) + "!")
				target.health -= damage
				
				#Update the HP Bar.
				for targeted in entities:
					if targeted["name"] == target.name:
						targeted["instance"].update_HP(target.health, target.max_health)
						if target.health <= 0: #Check for character death, remove if there is.
							targeted["instance"].queue_free()
							entities.pop_at(entities.find(targeted))
							PartyManager.party.pop_at(target_index)
							if PartyManager.party.size() == 0:
								won = false
								self.visible = false
								for enemy in entities:
									enemy.queue_free()
								entities.clear()
								done.emit()
								return #Maybe change scene to a game over screen instead of emiting.
							break
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
				log_action(entity["name"] + "'s", "turn.")
				
				await wait_for_button_press()
				while player_turn:
					match pressed_button:
						"Fight":
							player_turn = false
							turn_container.visible = false
							target_enemy_container.visible = true
							await wait_for_enemy_target_button_press()
							while enemy_button_pressed:
								target_enemy_container.visible = false
								enemy_button_pressed = false
								var damage = max(current_player.attack - enemy_instance_targeted.DEF, 0)
								enemy_instance_targeted.HP -= damage
								log_action(current_player.name, "attacks", enemy_instance_targeted.enemy_name, "for " + str(damage) + '!')
								enemy_instance_targeted.update_HP()
								if enemy_instance_targeted.HP <= 0:
									var index = 0
									for enemy in entities:
										if enemy is enemy_template_for_fight:
											if enemy == enemy_instance_targeted:
												enemy_instance_targeted.enemy_instance_button.queue_free()
												entities.pop_at(index)
												break
										index += 1
									enemy_instance_targeted.queue_free()
									if entities.size() == PartyManager.party.size():
										won = true
										self.visible = false
										for character in entities:
											character["instance"].queue_free()
										entities.clear()
										done.emit()
										return
						"Guard":
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
							if((randi() % 100) + (current_player.dodge / 10)) >= 50:
								won = false
								log_action("Successfully", "ran!")
								await get_tree().create_timer(1.0).timeout
								self.hide()
								for instance in entities:
									if instance is enemy_template_for_fight:
										instance.enemy_instance_button.queue_free()
										instance.queue_free()
									else:
										instance["instance"].queue_free()
								entities.clear()
								done.emit()
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
		action_message += " %s" % result
	
	#Add the message to the action_box.
	action_box.append_text("[color=yellow]%s[/color]\n" % action_message)
	action_box.scroll_to_line(action_box.get_line_count() - 1)  #Auto-scroll to the latest message.
