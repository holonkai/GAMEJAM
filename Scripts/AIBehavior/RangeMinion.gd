extends CharacterBody2D
#setting variables
var moveSpeed=50
var clicked: bool=false
var path: PackedVector2Array
var Health: int=10
var damage: float=2.0
var dmg_tw: Tween = null
@onready var cam: Camera2D=get_viewport().get_camera_2d()
var rng= RandomNumberGenerator.new()
func _ready() -> void:
	#insantiating object
	$Selector.hide()

	$HPBAR.max_value=Health
	print($HPBAR.max_value)
	$HPBAR.value=Health
	$HPBAR.visible=false

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
	if(path.size()<1):
		return
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
			$Icon.look_at(path[0])
			$Icon.rotation_degrees-=90

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

func DamageText(amount: int, duration:float =0.5):
	#activates the tweens for the damage numbers
	if dmg_tw:
		dmg_tw.kill()
	$DamageLabel.text=str(amount)
	$DamageLabel.modulate.a=1.0
	$DamageLabel.position.y=-75
	$DamageLabel.position.x=0
	dmg_tw=get_tree().create_tween()
	dmg_tw.set_parallel(true)
	dmg_tw.tween_property($DamageLabel,"modulate:a",0.0,duration)
	dmg_tw.tween_property($DamageLabel,"position:y",-30.0,duration).as_relative().\
		set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
	pass

func TakeDamage(amount: int):
	#reduces health and plays visual effects
	Health-=amount
	DamageText(amount)
	$HPBAR.value=Health
	$HPBAR.visible=true
	if(Health<=0):
		$Death.pitch_scale=rng.randf_range(.8,1.2)
		$Death.play()
		await get_tree().create_timer(.2).timeout
		queue_free()
		
func Heal(amount: int):
	Health = $HPBAR.max_value+amount
	$HPBAR.max_value=Health
	$HPBAR.value = Health
	$HPBAR.visible = true


func _on_timer_timeout() -> void:
	#print(position)
	#hits enemies after a random amount of time
	var Enemies=get_tree().get_nodes_in_group("Enemies")
	if(Enemies.size()<1):
		moveSpeed=50
		return
	var closest=Enemies[0]
	$Timer.wait_time=rng.randf_range(2,3)
	for Enemy in Enemies:
		
		if((global_position-Enemy.global_position).length()<(global_position-closest.global_position).length()):
			closest=Enemy
	if((global_position-closest.global_position).length()<200):
		closest.TakeDamage(rng.randi_range(ceili(damage/1.5),damage*1.5))
		$Icon.look_at(closest.global_position)
		$Icon.rotation_degrees-=90
		$LaserRay.look_at(closest.global_position)
		$LaserRay.isCasting=true
		#print(rng.randf_range(.7,1.3))
		$LaserShootBang.pitch_scale=rng.randf_range(.7,1.3)
		$LaserShootBang.play()
		moveSpeed=25
		await get_tree().create_timer(.1).timeout
		$LaserRay.isCasting=false
	else:
		moveSpeed=50
