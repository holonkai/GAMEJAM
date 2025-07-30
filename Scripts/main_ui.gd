extends Control


var gold: int=600

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
	
#ult button pop up text and effect on gold count
@onready var ult_pop_up = $"background/CanvasLayer/skills/VBoxContainer2/buttonult/UltPopup"
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

#skill pop up drag








	



#range upgrade pop up text and effect on gold count
@onready var range_upgrade_text = $"background/CanvasLayer/minion upgrade/rangeminionupgrade/rangeupgradebutton/range upgrade text"
func _on_rangeupgradebutton_button_down() -> void:
	var cost = 12
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		
		
		range_upgrade_text.text = "RANGE MINION UPGRADE"
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
		
		await get_tree().create_timer(0.5).timeout
		melee_upgrade_text.visible = false
	else:
		melee_upgrade_text.text = "UR POOR"
		melee_upgrade_text.visible = true
		
		await get_tree().create_timer(0.5).timeout
		melee_upgrade_text.visible = false

#skill upgrade pop up text and effect on gold count
@onready var skill_upgrade_text = $"background/CanvasLayer/upgrade skills/skillupgrade/skillupgradebutton/skill upgrade text"
func _on_skillupgradebutton_button_down() -> void:
	var cost = 14
	if gold >= cost:
		gold -= cost 
		update_gold_display()
		
		
		skill_upgrade_text.text = "SKILL UPGRADE"
		skill_upgrade_text.visible = true
		
		await get_tree().create_timer(0.5).timeout
		skill_upgrade_text.visible = false
	else:
		skill_upgrade_text.text = "UR POOR"
		skill_upgrade_text.visible = true
		
		await get_tree().create_timer(0.5).timeout
		skill_upgrade_text.visible = false
		
#skills drag on screen 
@onready var buttonskill = $background/CanvasLayer/skills/VBoxContainer3/Buttonskill
@onready var button_vile = $background/CanvasLayer/skills/VBoxContainer3/Buttvile
@onready var button_ult = $background/CanvasLayer/skills/VBoxContainer3/Buttonult

@onready var skill_art = $background/CanvasLayer/skills/VBoxContainer3/SkillArt
@onready var vile_art = $background/CanvasLayer/skills/VBoxContainer/VileArt
@onready var ult_art = $background/CanvasLayer/skills/VBoxContainer2/UltArt

var dragging: bool = false
var dragged_art: Node2D = null
var drag_offset: Vector2 = Vector2.ZERO

#func _ready():
	#buttonskill.pressed.connect(_on_buttonskill_pressed)
	#button_vile.pressed.connect(_on_buttonvile_pressed)
	#button_ult.pressed.connect(_on_buttonult_pressed)

func _start_drag(art_node: Node2D) -> void:
	dragged_art = art_node
	dragged_art.visible = true
	drag_offset = dragged_art.global_position - get_global_mouse_position()
	dragging = true


func _on_buttonskill_pressed() -> void:
	_start_drag(skill_art)


func _on_buttonvile_pressed() -> void:
	_start_drag(vile_art)


func _on_buttonult_pressed() -> void:
		_start_drag(ult_art)

func _process(delta: float) -> void:
	if dragging and dragged_art:
		dragged_art.global_position = get_global_mouse_position() + drag_offset

func _input(event):
	if dragging and event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			# Optional: Handle dropping on valid targets here
			dragging = false
			if dragged_art:
				dragged_art.visible = false
				dragged_art = null

func _get_enemy_under_mouse() -> Node:
	var space_state = get_world_2d().direct_space_state
	var mouse_pos = get_global_mouse_position()
	
	var result = space_state.intersect_point(mouse_pos)
	
	for r in result:
		if r.collider.has_method("TakeDamage"):
			return r.collider
	return null
