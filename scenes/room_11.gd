extends Node2D

@onready var boss = $Enemy as CharacterBody2D

var player = scene_manager.player
# Called when the node enters the scene tree for the first time.
func _ready():
	if scene_manager.player:
		add_child(scene_manager.player)
