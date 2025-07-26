extends Control

var selecting: bool = false
var dragStart: Vector2
var selectBox: Rect2

func _input(e: InputEvent) -> void:
	if e is InputEventMouseButton and e.button_index==MOUSE_BUTTON_LEFT:
		if(e.pressed):
			selecting=true 
			dragStart=e.position
			
		else:
			selecting=false
			if dragStart.is_equal_approx(e.position):
				selectBox=Rect2(e.position,Vector2.ZERO)
			update_selected_units()
			queue_redraw()
	elif selecting and e is InputEventMouseMotion:
		var x_min=min(dragStart.x,e.position.x)
		var y_min=min(dragStart.y,e.position.y)
		selectBox=Rect2(x_min,y_min,max(dragStart.x,e.position.x)-x_min,max(dragStart.y,e.position.y)-y_min)
		update_selected_units()
		queue_redraw()

func _draw():
	
	if not selecting: return
	draw_rect(selectBox,Color("#00ff0066"))
	draw_rect(selectBox,Color('#00ff00'),false,2.0)

func update_selected_units():
	for unit in get_tree().get_nodes_in_group("selectableUnits"):
		if(unit.is_in_selection_box(selectBox)):
			unit.select()
		else:
			unit.deselect()
