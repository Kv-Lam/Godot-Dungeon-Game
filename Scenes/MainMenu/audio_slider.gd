extends Control

@onready var audio_name = $"HBoxContainer/Audio Name" as Label
@onready var audio_number = $"HBoxContainer/Audio Number" as Label
@onready var h_slider = $HBoxContainer/HSlider as HSlider

@export_enum("Master", "Music", "SFX") var bus_name: String

var bus_index: int = 0 #Default to Master.

# Called when the node enters the scene tree for the first time
func _ready():
	#Set up the bus index first.
	get_bus_name_by_index()
	
	#Load audio settings from SettingsManager and apply to AudioServer.
	load_audio()

	#Set slider value based on loaded settings.
	set_slider_value()

	#Connect the slider's value_changed signal.
	h_slider.value_changed.connect(on_value_changed)

	#Update UI.
	set_audio_name()
	set_audio_number()


func set_audio_name() -> void:
	audio_name.text = str(bus_name) + " Volume"


func set_audio_number() -> void:
	audio_number.text = str(round(h_slider.value * 100)) + '%'


func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)


func load_audio() -> void:
	#Load the saved audio value from SettingsManager
	var saved_audio = SettingsManager.load_audio(bus_name)
	if saved_audio != null:
		#Apply saved value to AudioServer
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(saved_audio))


func set_slider_value() -> void:
	#Sync slider value with AudioServer
	var current_volume = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	h_slider.value = current_volume
	set_audio_number()


func on_value_changed(value: float) -> void:
	#Update the AudioServer with the new value
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_number()

	SettingsManager.save_audios(bus_name, value)
