extends CharacterBody2D
const moveSpeed=5000.0
var clicked: bool=false

@export var Goal: Node = null
@onready var cam: Camera2D=get_viewport().get_camera_2d()
func _ready() -> void:
	$Selector.hide()
	$NavigationAgent2D.target_position=Goal.global_position

func _input(event):
	
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		clicked=false
		var mouse_pos = get_viewport().get_mouse_position()
		if $CollisionShape2D.shape is CircleShape2D:
			if $CollisionShape2D.shape.get_rect().has_point(to_local(mouse_pos)):
				clicked=true
		
func is_in_selection_box(box:Rect2):
	return box.has_point(global_position)  or clicked

func select():
	$Selector.show()
	add_to_group("selected-units")

func deselect():
	$Selector.hide()
	remove_from_group("selected-units")

func _physics_process(delta: float) -> void:
	if(!$NavigationAgent2D.is_target_reached()):
		var navPointDirection=to_local($NavigationAgent2D.get_next_path_position()).normalized()
		#velocity= navPointDirection*moveSpeed*delta
		move_and_slide()



func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position!=Goal.global_position:
		$NavigationAgent2D.target_position=Goal.global_position

	
