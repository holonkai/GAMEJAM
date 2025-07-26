extends CharacterBody2D
#setting variables
const moveSpeed=50
var clicked: bool=false
var path: PackedVector2Array
@onready var cam: Camera2D=get_viewport().get_camera_2d()

func _ready() -> void:
	#insantiating object
	$Selector.hide()
	set_process(false)

func _input(event):
	###This is the singular unit selection code
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		clicked=false
		var mouse_pos = get_viewport().get_mouse_position()
		if $CollisionShape2D.shape is CircleShape2D:
			if $CollisionShape2D.shape.get_rect().has_point(to_local(mouse_pos)):
				clicked=true

func move(_path:PackedVector2Array):
	#handling movement
	path=_path

	set_process(true)

func _process(delta: float) -> void:
	#finding the distance between target and global position and moving towards target
	var targetPos=path[0]
	var diff= targetPos-global_position
	if (diff.length()>1):
		var dir=diff.normalized()
		global_position+=dir*delta*moveSpeed
	else:
		path.remove_at(0)
		#print(global_position)
		if(path.is_empty()):
			#print("huh? part 2")
			set_process(false)
		else:
			look_at(path[0])

func is_in_selection_box(box:Rect2):
	#checking to see if the unit is selected
	return box.has_point(global_position)  or clicked

func select():
	#selecting the unit
	$Selector.show()
	add_to_group("selected-units")

func deselect():
	#deselecting the unit
	$Selector.hide()
	remove_from_group("selected-units")


	
