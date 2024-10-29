extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void: #Calling
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void: #Always running
	var exp = 0
	var level = {"Level 1": 10, "Level 2" : 50, "Level 3" : 150, "Level 4" : 500, "Level 5" : 1000, 
				 "Level 6" : 2000, "Level 7" : 5000, "Level 8" : 12000, "Level 9" : 20000, "Level 10" : 50000}
	
	#print(level.Level 1)
