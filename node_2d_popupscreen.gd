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
		pop_up_wave_count.text = "Wave: %d" % Singleton.maxWaves
	print("weewoo",Singleton.maxWaves)
	set_process(true)

func _on_playbutton_button_down() -> void:
	canvas_layer.hide()
	get_tree().change_scene_to_file("res://Test.tscn")
	started = true
	#start_game()
	
#func start_game() -> void
	#spawn_minions     

	
	
func start_waves() -> void:
	if $WaveTimer:
		$WaveTimer.start()

func _process(delta: float) -> void:
	if started: 
		check_lose_condition()

func check_lose_condition() -> void:
	if gold < 6 and minions.size() == 0:
		print("Loss condition met")
		on_player_lose()

func on_player_lose() -> void:
	started = true
	start_panel.visible = true
	gold = 30
	minions.clear()
	canvas_layer.show()


func _on_tutorialbutton_button_down() -> void:
	get_tree().change_scene_to_file("res://Levels/Tutorial.tscn")
