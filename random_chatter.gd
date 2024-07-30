extends Node2D

var shadow_sounds = [
	"res://sounds/chatter_1.wav",
	"res://sounds/chatter_2.wav",
	"res://sounds/chatter_3.wav",
	"res://sounds/whisper_1.wav",
	"res://sounds/whisper_3.wav",
	"res://sounds/whisper_2.wav",
	"res://sounds/whisper_4.wav",
	"res://sounds/whisper_5.wav"
]

func play_random_sound():
	var random_index = randi() % shadow_sounds.size() 
	$AudioStreamPlayer2D.stream = load(shadow_sounds[random_index]) 
	$AudioStreamPlayer2D.pitch_scale = randf_range(0.75, 1.1)
	$AudioStreamPlayer2D.play()  # Play the sound

func _ready():
	randomize()
