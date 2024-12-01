class_name Player extends CharacterBody2D

@onready var fight = $"../Fight"
@onready var player_camera = $Camera2D


const SPEED = 300.0
var health = 100


func get_input(): #Deals with 8-way movement and rotation of character.
	var movement = Input.get_vector("left", "right", "up", "down")
	velocity = movement * SPEED
	if Input.is_action_pressed("sprint"): velocity *= 2 #Double speed of character when sprinting.
	if velocity.length(): 
		var snapped_angle = round(movement.angle() / (PI / 2)) * (PI / 2) #Makes it to where character will always rotate to one of the cardinal directions.
		rotation = lerp_angle(rotation, snapped_angle, 1) #If there is movement, change rotation of character.


func _physics_process(_delta):
	get_input()
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision and collision.get_collider() is Enemy:
			print("Fight!")
			enter_combat(self)


func enter_combat(player: CharacterBody2D):
	var fight_camera = fight.get_child(1)
	var ui_nodes: Array = fight.get_children()
	
	#Hide the player and make fight scene visible.
	player.visible = false
	player_camera.enabled = false
	fight.visible = true  # Show combat scene
	fight_camera.enabled = true
	
	#Pause the world (stop player movement, enemies, etc.).
	for node in get_tree().current_scene.get_children():
		if node.name != "Player":
			node.visible = false
			node.set_process(false)
			node.set_physics_process(false)
	
	player.set_process(false)
	player.set_physics_process(false)
	

	# Ensure the UI remains interactive
	#for ui_node in ui_nodes:
		#ui_node.set_process(true)  # Keep UI active (buttons, menus, etc.)
		#ui_node.set_physics_process(false)  # Disable physics, only need process for interaction
