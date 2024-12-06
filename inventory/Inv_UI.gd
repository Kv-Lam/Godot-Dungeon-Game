extends Control

@onready var inv: Inv = preload("res://inventory/playerinv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

func _ready():
	update_slots()
	close()

#Updatingg the slots based on what is picked up and removed
func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])

#Player can press "i" to open the inventory
func _process(delta):
	if Input.is_action_just_pressed("i"):
		if is_open:
			close()
		else:
			open()


#Visibility of the inventory in game
func open():
	self.visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false
