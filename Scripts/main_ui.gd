extends Control
var MeleeMinion=preload("res://Prefabs/Meleeminion.tscn")
var RangeMinion=preload("res://Prefabs/RangeMinion.tscn")

var gold: int=300
var rng= RandomNumberGenerator.new()
@onready var gold_label = $background/CanvasLayer/goldscountpanel/GoldLabel
func _ready():
	update_gold_display()
	
func update_gold_display():
	gold_label.text = "Gold: %d" %gold
	
func add_gold(amount: int):
	gold += amount 
	update_gold_display()

#+1 range minion pop up text and effect on gold count
@onready var range_pop_up = $"background/CanvasLayer/LittleGuyEconomy/shopbox/range minion/RangePopup"
func _on_range_minion_button_down() -> void:
	var cost = 10
	
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		
		range_pop_up.text = "RANGE MINION +1"
		range_pop_up.visible = true
		var newGuy=RangeMinion.instantiate()
		newGuy.position=Vector2(rng.randi_range(0,100),rng.randi_range(400,500))
		add_sibling(newGuy)
		await get_tree().create_timer(0.5).timeout
		range_pop_up.visible = false
	else:
		range_pop_up.text = "UR POOR"
		range_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		range_pop_up.visible = false
		
#+1 melee minion pop up text and effect on gold count
@onready var melee_pop_up = $"background/CanvasLayer/LittleGuyEconomy/shopbox2/melee minion/MeleePopup"
func _on_melee_minion_button_down() -> void:
	var cost = 8
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		
		var newGuy=MeleeMinion.instantiate()
		newGuy.position=Vector2(rng.randi_range(0,100),rng.randi_range(400,500))
		add_sibling(newGuy)
		melee_pop_up.text = "MELEE MINION +1"
		melee_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		melee_pop_up.visible = false
	else:
		melee_pop_up.text = "UR POOR"
		melee_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		melee_pop_up.visible = false
		
#skill button pop up text and effect on gold count
@onready var skill_pop_up = $background/CanvasLayer/skills/VBoxContainer3/Buttonskill/SkillPopup
	
#ult button pop up text and effect on gold count
@onready var ult_pop_up = $"background/CanvasLayer/skills/VBoxContainer2/buttonult/UltPopup"
func _on_buttonult_button_down() -> void:
	var cost = 12
	if gold >= cost:
		gold -= cost
		#_start_drag(ult_art)
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


	
#evil range minin pop up text and effect on gold count
@onready var evil_range_minion_pop_up = $"background/CanvasLayer/bigguy/evilrangeminion/evil range minion/EvilRangePopup"
func _on_evil_range_minion_button_down() -> void:
	evil_range_minion_pop_up.text = "BAD RANGE MINION"
	evil_range_minion_pop_up.visible = true
	
	await get_tree().create_timer(0.5).timeout
		
	evil_range_minion_pop_up.visible = false
	
	
#evil melee minion pop up text and effect on gold count
@onready var evil_melee_minion_pop_up = $"background/CanvasLayer/bigguy/evilmeleeminion/evil melee minion/EvilMeleePopup"
func _on_evil_melee_minion_button_down() -> void:
	evil_melee_minion_pop_up.text = "BAD MELEE MINION"
	evil_melee_minion_pop_up.visible = true
	
	await get_tree().create_timer(0.5).timeout
		
	evil_melee_minion_pop_up.visible = false
	
#vile pop up text and effect on gold count
@onready var vile_pop_up = $background/CanvasLayer/skills/VBoxContainer/buttonvile/VilePopup
func _on_vile_button_down() -> void:
	var cost = 8
	if gold >= cost:
		gold -= cost
		update_gold_display()
	
		vile_pop_up.text = "HEAL"
		vile_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		vile_pop_up.visible = false
	else:
		vile_pop_up.text = "UR POOR"
		vile_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		vile_pop_up.visible = false

#range upgrade pop up text and effect on gold count
@onready var range_upgrade_text = $"background/CanvasLayer/minion upgrade/rangeminionupgrade/rangeupgradebutton/range upgrade text"
func _on_rangeupgradebutton_button_down() -> void:
	var cost = 12
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		
		
		range_upgrade_text.text = "RANGE MINION UPGRADE"
		var Minions=get_tree().get_nodes_in_group("Ranged")
		for minion in Minions:
			minion.Health+=2
			minion.damage+=.25
		range_upgrade_text.visible = true
		
		await get_tree().create_timer(0.5).timeout
		range_upgrade_text.visible = false
	else:
		range_upgrade_text.text = "UR POOR"
		range_upgrade_text.visible = true
		
		await get_tree().create_timer(0.5).timeout
		range_upgrade_text.visible = false
		
#melee upgrade pop up text and effect on gold count
@onready var melee_upgrade_text = $"background/CanvasLayer/minion upgrade/meleeminionupgrade/meleeupgrademinion/melee upgrade text"
func _on_meleeupgrademinion_button_down() -> void:
	var cost = 10
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		
		
		melee_upgrade_text.text = "MELEE MINION UPGRADE"
		melee_upgrade_text.visible = true
		var Minions=get_tree().get_nodes_in_group("Melee")
		for minion in Minions:
			minion.Health+=5
			minion.damage+=.5
		await get_tree().create_timer(0.5).timeout
		melee_upgrade_text.visible = false
	else:
		melee_upgrade_text.text = "UR POOR"
		melee_upgrade_text.visible = true
		
		await get_tree().create_timer(0.5).timeout
		melee_upgrade_text.visible = false

#skill upgrade pop up text and effect on gold count

#skills drag on screen 
@onready var buttonskill = $background/CanvasLayer/skills/VBoxContainer3/Buttonskill
@onready var button_vile = $background/CanvasLayer/skills/VBoxContainer/buttonvile
@onready var button_ult = $background/CanvasLayer/skills/VBoxContainer2/buttonult

@onready var skill_art = $background/CanvasLayer/skills/VBoxContainer3/SkillArt
@onready var vile_art = $background/CanvasLayer/skills/VBoxContainer/VileArt
@onready var ult_art = $background/CanvasLayer/skills/VBoxContainer2/UltArt

var dragging: bool = false
var dragged_art: Node2D = null
#var drag_offset: Vector2 = Vector2.ZERO

const COST_SKILL = 6
const COST_VILE = 8
const COST_ULT = 12

func _start_drag(art_node: Node2D) -> void:
	dragged_art = art_node
	dragged_art.visible = true
	#drag_offset = dragged_art.global_position - get_global_mouse_position()
	dragging = true


func _on_buttonskill_pressed() -> void:
	var cost = 6
	if gold >= cost:
		gold -= cost
		update_gold_display()
		
		_start_drag(skill_art)
		
		skill_pop_up.text = "SKILL"
		skill_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		skill_pop_up.visible = false
	else:
		skill_pop_up.text = "UR POOR"
		skill_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		skill_pop_up.visible = false


func _on_buttonvile_pressed() -> void:
	var cost = 6
	if gold >= cost:
		gold -= cost
		update_gold_display()
		
		_start_drag(vile_art)
		
		vile_pop_up.text = "HEAL"
		vile_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		vile_pop_up.visible = false
	else:
		vile_pop_up.text = "UR POOR"
		vile_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		vile_pop_up.visible = false



func _on_buttonult_pressed() -> void:
	var cost = 12
	if gold >= cost:
		gold -= cost
		update_gold_display()
		
		_start_drag(ult_art)
	
		ult_pop_up.text = "ULT"
		ult_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		ult_pop_up.visible = false
	else:
		ult_pop_up.text = "UR POOR"
		ult_pop_up.visible = true
		
		await get_tree().create_timer(0.5).timeout
		ult_pop_up.visible = false

	#_start_drag(ult_art)
	pass


func _process(delta: float) -> void:
	if dragging and dragged_art:
		dragged_art.global_position = get_global_mouse_position() #+ drag_offset

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and skill_art.visible:
			var enemies = get_tree().get_nodes_in_group("Enemies")
			var mouse_pos = get_viewport().get_mouse_position()
			
			for enemy in enemies:
				if (mouse_pos - enemy.global_position).length() < 50:
					enemy.TakeDamage(5)
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and ult_art.visible:
			var enemies = get_tree().get_nodes_in_group("Enemies")
			var mouse_pos = get_viewport().get_mouse_position()
			
			for enemy in enemies:
				if (mouse_pos - enemy.global_position).length() <100:
					enemy.TakeDamage(10)
					
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and vile_art.visible:
			var selectableunits = get_tree().get_nodes_in_group("selectableUnits")
			var mouse_pos = get_viewport().get_mouse_position()
			
			for minion in selectableunits:
				if (mouse_pos - minion.global_position).length() <50:
					minion.Heal(10)
					
	if dragging and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			dragging = false
			if dragged_art:
				dragged_art.visible = false
				dragged_art = null





	


	
	
