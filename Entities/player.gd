class_name Player extends CharacterBody2D

@onready var fight = $"../Fight"
@onready var player_camera = $Camera2D
@onready var animations = $AnimationPlayer
@onready var scene_transition_screen = $SceneTransition


const SPEED = 300.0
var health = 100

@export var inv:Inv


func get_input(): #Deals with 8-way movement and rotation of character.
	var movement = Input.get_vector("left", "right", "up", "down")
	velocity = movement * SPEED
	if Input.is_action_pressed("sprint"): velocity *= 2 #Double speed of character when sprinting.
	#if Input.is_action_pressed("interact"): 
	if velocity.length(): 
		var snapped_angle = round(movement.angle() / (PI / 2)) * (PI / 2) #Makes it to where character will always rotate to one of the cardinal directions.
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
			if collision.get_collider() is Enemy:
				#Add sceen transition
				enter_combat(self, collision.get_collider().name)
			if collision.get_collider() is SceneTrigger:
				await scene_transition_screen.play("ScreenTransition").complete
				scene_transition_screen.play("ScreenTransitionFadeOut")
				


func enter_combat(player: CharacterBody2D, collided_enemy: String):
	var fight_camera = fight.get_child(1)
	var ui_nodes: Array = fight.get_children()
	
	#Pause the world (stop player movement, enemies, etc.).
	for node in get_tree().current_scene.get_children():
		if node.name != "Player":
			node.visible = false
			node.set_process(false)
			node.set_physics_process(false)
	
	player.set_process(false)
	player.set_physics_process(false)
	
	#Hide the player and make fight scene visible.
	player.visible = false
	player_camera.enabled = false
	fight.visible = true  # Show combat scene
	fight_camera.enabled = true
	
	fight.set_up_fight(collided_enemy)
	
	# Ensure the UI remains interactive
	#for ui_node in ui_nodes:
		#ui_node.set_process(true)  # Keep UI active (buttons, menus, etc.)
		#ui_node.set_physics_process(false)  # Disable physics, only need process for interaction
