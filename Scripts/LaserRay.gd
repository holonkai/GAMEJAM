@tool
extends RayCast2D

var tween: Tween=null
var growthTime:=.05
@export var isCasting: bool=false:set=SetIsCasting
@onready var castSpeed=7000
@export var maxLength=1400.0
@export var color: =Color.WHITE:set=setColor
@onready var line2d:Line2D=$Line2D
@onready var lineWidth:=line2d.width

func setColor(newColor: Color)->void:
	color=newColor
	if(line2d==null):
		return
	line2d.modulate=newColor
	
func _physics_process(delta: float) -> void:
	target_position.x=move_toward(target_position.x,maxLength,castSpeed*delta)
	#print(target_position.x)
	var laserEndPosition:=target_position
	force_raycast_update()
	if(is_colliding()):
		laserEndPosition=to_local(get_collision_point())
	line2d.points[1]=laserEndPosition

	



func appear():
	line2d.visible=true
	if(tween) and tween.is_running():
		tween.kill()
	tween=create_tween()
	tween.tween_property(line2d,"width",lineWidth,growthTime*2.0).from(0.0)
	

func disappear():
	if(tween) and tween.is_running():
		tween.kill()
	tween=create_tween()
	tween.tween_property(line2d,"width",0.0,growthTime*2.0).from_current()
	tween.tween_callback(line2d.hide)


func SetIsCasting(value:bool):
	if(isCasting==value):
		return
	isCasting=value
	set_physics_process(isCasting)
	if(not line2d):
		return
	if(isCasting==false):
		target_position=Vector2.ZERO
		disappear()
	else:
		appear()
		
