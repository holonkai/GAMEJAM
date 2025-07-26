extends Control

var gold: int=2

@onready var gold_label = $background/LittleGuyEconomy/CanvasLayer/GoldLabel
# @onready var range_minion_button = $background/LittleGuyEconomy/shopbox/range_minion
# @onready var melee_minion_button = $background/LittleGuyEconomy/shopbox2/melee_minion

func _ready():
	update_gold_display()
	# range_minion_button.pressed.connect(_on_range_minion_pressed)
	# melee_minion_button.pressed.connect(_on_melee_minion_pressed)
	
func update_gold_display():
	gold_label.text = "Gold: %d" %gold

		
func _on_range_minion_button_down() -> void:
	var cost = 8
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		print("range minion x1")
	else:
		print("ur poor")


func _on_melee_minion_button_down() -> void:
	var cost = 10
	if gold >= cost:
		update_gold_display()
		print("melee minion x1")
	else:
		print("ur poor")
