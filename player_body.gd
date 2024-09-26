extends CharacterBody2D

const SPEED = 300.0

func get_input(): #Deals with 8-way movement and rotation of character.
	var movement = Input.get_vector("left", "right", "up", "down")
	velocity = movement * SPEED
	if Input.is_action_pressed("sprint"): velocity *= 2 #Double speed of character when sprinting.
	if velocity.length(): rotation = lerp_angle(rotation, movement.angle(), .1) #If there is movement, change rotation of character.

func _physics_process(_delta):
	get_input()
	move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision and collision.get_collider().name == "TestEnemy":
			print("Fight.")
	#var collision = move_and_collide(velocity * _delta)
	#if collision and collision.get_collider().name == "TestEnemy": #Work on detecting what is collided with, so on enemy collision a fight is started.
		#print("Collision.")
