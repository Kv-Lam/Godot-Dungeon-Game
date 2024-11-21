extends Control

@onready var audio_name = $"HBoxContainer/Audio Name" as Label
@onready var audio_number = $"HBoxContainer/Audio Number" as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider

@export_enum("Master", "Music", "SFX") var bus_name : String

var bus_index : int = 0 #Default Master.


# Called when the node enters the scene tree for the first time.
func _ready():
	h_slider.value_changed.connect(on_value_changed)
	get_bus_name_by_index()
	set_audio_name()
	set_slider_value()

func set_audio_name() -> void:
	audio_name.text = str(bus_name) + " Volume"


func set_audio_number() -> void:
	audio_number.text = str(h_slider.value * 100) + '%'


func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)


func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_number()


func on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_number()
