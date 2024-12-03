class_name Player extends CharacterBody2D

@onready var fight = $"../Fight"
@onready var fight_camera = $"../Fight/Camera2D"
@onready var player_camera = $Camera2D
@onready var animations = $AnimationPlayer
@onready var scene_transition_screen = $SceneTransition


const SPEED = 300.0
var health = 100
var allow_collisions: bool = true

@export var inv:Inv


func get_input(): #Deals with 8-way movement and rotation of character.
	var movement = Input.get_vector("left", "right", "up", "down")
	velocity = movement * SPEED
	if Input.is_action_pressed("sprint"): velocity = movement * (SPEED + 100.0)
	#if Input.is_action_pressed("open_inventory"):
	#if Input.is_action_pressed("interact"): 
	#if velocity.length(): 
		#var snapped_angle = round(movement.angle() / (PI / 2)) * (PI / 2) #Makes it to where character will always rotate to one of the cardinal directions.
		#rotation = lerp_angle(rotation, snapped_angle, 1) #If there is movement, change rotation of character.

func _update_animation():
	if velocity.length() == 0:
		animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		
		animations.play("Walk" + direction + "David")

func _physics_process(_delta):
	get_input()
	move_and_slide()
	_update_animation()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision:
			if allow_collisions and collision.get_collider() is Enemy:
				#Add sceen transition
				allow_collisions = false
				enter_combat(self, collision)
			if collision.get_collider() is SceneTrigger:
				await scene_transition_screen.play("ScreenTransition").complete
				scene_transition_screen.play("ScreenTransitionFadeOut")
				


func enter_combat(player: CharacterBody2D, enemy_to_free):
	var collided_enemy: String = enemy_to_free.get_collider().name
	
	#Pause the world (stop player movement, enemies, etc.).
	for node in get_tree().current_scene.get_children():
		if node.name != "Player":
			node.visible = false
			node.set_process(false)
			node.set_physics_process(false)
	
	
	set_player_processes(player, false)
	
	#Hide the player and make fight scene visible.
	set_visibilities(player, true)
	
	fight.set_up_fight(collided_enemy)
	await fight.done
	if fight.won:
		set_visibilities(player, false)
		enemy_to_free.get_collider().queue_free()
		for node in get_tree().current_scene.get_children():
			if node.name != "Player":
				node.visible = true
				node.set_process(true)
				node.set_physics_process(true)
		set_player_processes(player, true)
		allow_collisions = true
	elif PartyManager.party.size() == 0: #Party wipe.
		get_tree().change_scene_to_file("res://scenes/game_over_screen.tscn")
	else: #Ran from fight.
		allow_collisions = false
		set_visibilities(player, false)
		for node in get_tree().current_scene.get_children():
			if node.name != "Player": node.visible = true
		set_player_processes(player, true)
		await get_tree().create_timer(3).timeout
		allow_collisions = true
		for node in get_tree().current_scene.get_children():
			if node.name != "Player":
				node.set_process(true)
				node.set_physics_process(true)
		allow_collisions = true


func set_player_processes(player: CharacterBody2D, state: bool):
	player.set_process(state)
	player.set_physics_process(state)


func set_visibilities(player: CharacterBody2D, in_combat: bool) -> void: #If in_combat = true, make fight.visble = true
	player.visible = not in_combat
	player_camera.enabled = not in_combat
	fight.visible = in_combat
	fight_camera.enabled = in_combat
	


#func saveObject() -> Dictionary:
	#return {
		#"filepath": get_path(),
		#"level": self.level,
		#"health": self.health,
		#"max_health": self.max_health,
		#"attack": self.attack,
		#"defense": self.defense,
		#"mana_stamina": self.mana_stamina,
		#"has_mana": self.has_mana,
		#"position": self.global_position,
		#"velocity": self.velocity
	#}
#
#
#func loadObject(data: Dictionary) -> void:
	#self.level = data.get("level", 1) #Restore the level, default to 1
	#self.health = data.get("health", 100)  # Restore health, default to 100 if missing
	#self.max_health = data.get("max_health", 100) #Restore max health, default to 100
	#self.attack = data.get("attack", 30) #Restore attack ability, default to 30
	#self.defense = data.get("defense", 30) #Restore defense ability, default to 30
	#self.mana_stamina = data.get("mana_stamina", 100) #Resotre mana stamina, default to 100
	#self.has_mana = data.get("has_mana", false) #Restore if they have mana, default to no
	#self.global_position = data.get("position", Vector2.ZERO)  # Restore position
	#self.velocity = data.get("velocity", Vector2.ZERO)  # Restore velocity
