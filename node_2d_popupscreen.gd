extends Node2D

@onready var start_panel = $CanvasLayer/startpanel
@onready var play_button = $CanvasLayer/startpanel/playbutton
@onready var canvas_layer = $CanvasLayer
@onready var pop_up_wave_count = $CanvasLayer/startpanel/popupwavecount

var started: bool = true
var gold: int = 0
var minions: Array = []

func _ready() -> void:
	start_panel.visible = true
	if pop_up_wave_count:
		pop_up_wave_count.text = "Max Waves Cleared: %d" % Singleton.maxWaves
	print("weewoo",Singleton.maxWaves)
	set_process(true)

func _on_playbutton_button_down() -> void:
	canvas_layer.hide()
	get_tree().change_scene_to_file("res://Test.tscn")
	started = true
	#start_game()
	
func _on_tutorialbutton_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/Tutorial.tscn")
	


	


	
