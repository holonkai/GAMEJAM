extends Control

@onready var cam: Camera2D=get_viewport().get_camera_2d()
@onready var map: RID =cam.get_world_2d().navigation_map
var selecting: bool = false
var dragStart: Vector2
var selectBox: Rect2

func _input(e: InputEvent) -> void:
	### selecting units
	if e is InputEventMouseButton and e.button_index==MOUSE_BUTTON_LEFT:
		if(e.pressed):
			selecting=true 
			dragStart=e.global_position
			
		else:
			selecting=false
			if dragStart.is_equal_approx(e.global_position):
				selectBox=Rect2(e.global_position,Vector2.ZERO)
			update_selected_units()
			queue_redraw()
	elif selecting and e is InputEventMouseMotion:
		var x_min=min(dragStart.x,e.global_position.x)
		var y_min=min(dragStart.y,e.global_position.y)
		selectBox=Rect2(x_min,y_min,max(dragStart.x,e.global_position.x)-x_min,max(dragStart.y,e.global_position.y)-y_min)
		update_selected_units()
		queue_redraw()
	### moving units
	if e is InputEventMouseButton and e.button_index==MOUSE_BUTTON_RIGHT and e.pressed:
		move_selected_units(get_local_mouse_position())

func move_selected_units(pos: Vector2):
	#telling the units where to move (I'm scared :( )
	var units=get_tree().get_nodes_in_group("selected-units")
	pos=snap_to_map(pos)
	var positions=UnitFormation.line(pos,units.size())
	for i in units.size():
		print(NavigationServer2D.map_get_path(map, snap_to_map(units[i].global_position), snap_to_map(positions[i]),true))
		print(snap_to_map(units[i].global_position),snap_to_map(positions[i]))
		var path=NavigationServer2D.map_get_path(map, snap_to_map(units[i].global_position), snap_to_map(positions[i]),true)
		units[i].move(path)
		
func snap_to_map(pos: Vector2):
	#gets the closest map point
	return NavigationServer2D.map_get_closest_point(map,pos)
	
func _draw():
	#drawing the rectangle for the selection box
	if not selecting: return
	draw_rect(selectBox,Color("#00ff0066"))
	draw_rect(selectBox,Color('#00ff00'),false,2.0)

func update_selected_units():
	#identifying which units are and arent selected
	for unit in get_tree().get_nodes_in_group("selectableUnits"):
		if(unit.is_in_selection_box(selectBox)):
			unit.select()
		else:
			unit.deselect()
