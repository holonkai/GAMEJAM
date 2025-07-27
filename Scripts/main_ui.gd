extends Control

var gold: int=50


@onready var gold_label = $background/LittleGuyEconomy/CanvasLayer/GoldLabel
# @onready var range_minion_button = $background/LittleGuyEconomy/shopbox/range_minion
# @onready var melee_minion_button = $background/LittleGuyEconomy/shopbox2/melee_minion

func _ready():
	update_gold_display()
	# range_minion_button.pressed.connect(_on_range_minion_pressed)
	# melee_minion_button.pressed.connect(_on_melee_minion_pressed)
	
func update_gold_display():
	gold_label.text = "Gold: %d" %gold

@onready var range_pop_up = $"background/LittleGuyEconomy/shopbox/range minion/RangePopup"
func _on_range_minion_button_down() -> void:
	var cost = 8
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		
		range_pop_up.text = "RANGE MINION x1"
		range_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		range_pop_up.visible = false
	else:
		range_pop_up.text = "UR POOR"
		range_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		range_pop_up.visible = false
		
	
		
	#	print("RANGE MINION x1")
	#else:
		#print("UR POOR")

@onready var melee_pop_up = $"background/LittleGuyEconomy/shopbox2/melee minion/MeleePopup"
func _on_melee_minion_button_down() -> void:
	var cost = 10
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		
		
		melee_pop_up.text = "MELEE MINION x1"
		melee_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		melee_pop_up.visible = false
	else:
		melee_pop_up.text = "UR POOR"
		melee_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		melee_pop_up.visible = false
		

@onready var skill_pop_up = $background/skills/VBoxContainer3/Buttonskill/SkillPopup

func _on_buttonskill_button_down() -> void:
	var cost = 6
	if gold >= cost:
		gold -= cost
		update_gold_display()
		
		skill_pop_up.text = "SKILL"
		skill_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		skill_pop_up.visible = false
	else:
		skill_pop_up.text = "UR POOR"
		skill_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		skill_pop_up.visible = false
	
@onready var ult_pop_up = $"background/skills/VBoxContainer2/buttonult/UltPopup"

func _on_buttonult_button_down() -> void:
	var cost = 12
	if gold >= cost:
		gold -= cost
		update_gold_display()
	
		ult_pop_up.text = "ULT"
		ult_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		ult_pop_up.visible = false
	else:
		ult_pop_up.text = "UR POOR"
		ult_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		ult_pop_up.visible = false

	


	

@onready var evil_range_minion_pop_up = $"background/bigguy/evilrangeminion/evil range minion/EvilRangePopup"
func _on_evil_range_minion_button_down() -> void:
	evil_range_minion_pop_up.text = "BAD RANGE MINION"
	evil_range_minion_pop_up.visible = true
	
	await get_tree().create_timer(0.5).timeout
		
	evil_range_minion_pop_up.visible = false
	
	

@onready var evil_melee_minion_pop_up = $"background/bigguy/evilmeleeminion/evil melee minion/EvilMeleePopup"
func _on_evil_melee_minion_button_down() -> void:
	evil_melee_minion_pop_up.text = "BAD MELEE MINION"
	evil_melee_minion_pop_up.visible = true
	
	await get_tree().create_timer(0.5).timeout
		
	evil_melee_minion_pop_up.visible = false
	
