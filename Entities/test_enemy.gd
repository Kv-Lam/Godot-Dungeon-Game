class_name Enemy extends CharacterBody2D


@onready var player_manager = get_node("/root/PlayerManager")

@export var speed = 300.0
@export var follow_distance = 300.0 # Maybe edit this based on enemy?


#For following player.
var follow = false
var player: Node2D = null

func _ready():
	change_enemy_stats()
	player = player_manager.get_player()


func _physics_process(delta):
	# Distance the enemy is from the player.
	var distance_from_player = global_position.distance_to(player.global_position)
	
	if distance_from_player <= follow_distance:
		follow = true
	else:
		follow = false

	if follow:
		follow_player(delta)


func follow_player(delta):
	var direction = (player.global_position - global_position).normalized()
	
	velocity = direction * speed
	move_and_slide()


func change_enemy_stats() -> void:
	var enemy_types = ["Goblin", "Hound"] #Maybe use a dictionary instead for stats? Or just have stats for enemies in different file like player stats.
	self.name = enemy_types[randi() % enemy_types.size()]
	match(self.name):
		"Goblin":
			follow_distance = 300.0
			speed = 300.0
		"Hound":
			follow_distance = 150.0
			speed = 150.0
