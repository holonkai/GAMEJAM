extends Control
@onready var cam: Camera2D=get_viewport().get_camera_2d()
@onready var map: RID =cam.get_world_2d().navigation_map

func targetSelection(pos :Vector2):
	
	var targets=get_tree().get_nodes_in_group("selectableUnits")
	if(targets.size()<1):
		return pos
	var closest=targets[0].global_position
	for target in targets:
		if((pos-target.global_position).length()<(pos-closest).length()):
			closest=target.global_position
	return closest

func move_enemies():
	#telling the enemies where to move
	var units=get_tree().get_nodes_in_group("Enemies")
	if(units.size()>1):
		for i in units.size():
			var position=targetSelection(units[i].global_position)
			#print(units.size())
			var path=NavigationServer2D.map_get_path(map, snap_to_map(units[i].global_position), snap_to_map(position),true)
			#print(path)
			units[i].move(path)
			
func snap_to_map(pos: Vector2):
	#gets the closest map point
	return NavigationServer2D.map_get_closest_point(map,pos)

func _on_timer_timeout() -> void:
	move_enemies()
