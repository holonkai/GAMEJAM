extends Node2D

@onready var start_panel = $CanvasLayer/startpanel
@onready var play_button = $CanvasLayer/startpanel/playbutton
@onready var canvas_layer = $CanvasLayer
@onready var wave_control = get_node("/root/Node2D/WaveControl")
@onready var pop_up_wave_count = $CanvasLayer/startpanel/popupwavecount
@onready var waveCount = get_node("/root/Node2D/WaveCount")

var started: bool = true
var gold: int = 0
var minions: Array = []

func _ready() -> void:
	start_panel.visible = true

func _on_playbutton_button_down() -> void:
	canvas_layer.hide()
	started = true
	#start_game()
	
#func start_game() -> void
	#spawn_minions     
func start_game() -> void:
	wave_control.start_waves()
	
var wave_number: int = 0
func _on_wave_timer_timeout() -> void:
	waveCount+=1
	if pop_up_wave_count:
		pop_up_wave_count.text = "Wave: %d" % waveCount
	print(waveCount)
	set_process(true)
	
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
	wave_number = 0
	gold = 30
	minions.clear()
	canvas_layer.show()
