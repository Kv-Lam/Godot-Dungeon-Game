class_name Enemy extends CharacterBody2D

@export var speed = 450.0

var player_detected = false
var player : Node2D = null  # Reference to the detected player

@onready var detection_area = $Area2D
@onready var collision_shape_body = $CollisionShape2D  # For physical collisions
@onready var detection_range = $Area2D/DetectionRange

func _ready():
	# Connect Area2D signals for detection
	set_enemy_name()
	detection_area.body_entered.connect(on_body_entered_detection)
	detection_area.body_exited.connect(on_body_exited_detection)
	

func _physics_process(delta):
	if player_detected and player != null:
		follow_player(delta)

func set_enemy_name() -> void:
	var enemy_names = ["Goblin", "Wolf"]
	name = enemy_names[randi() % enemy_names.size()]
	resize_detection_range()
	
func resize_detection_range() -> void:
	match(name): #Resizes the DetectionRange node based on enemy name. Should change image of the enemy too.
		"Goblin":
			detection_range.shape.size = Vector2(400, 400) 
			speed = 300.0
		"Wolf":
			detection_range.shape.size = Vector2(800, 800)
			speed = 500.0

func follow_player(_delta):
	# Move towards the player
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide() #Need to change the rotation like player

# Area2D Detection Signals
func on_body_entered_detection(body):
	if body.name == "Player":
		player_detected = true
		player = body

func on_body_exited_detection(body):
	if body.name == "Player":
		player_detected = false
		player = null
