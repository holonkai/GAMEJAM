extends CharacterBody2D
#setting variables
var moveSpeed=30
var path: PackedVector2Array
var Health: int=20
var damage=1
var dmg_tw: Tween = null
func _ready() -> void:
	set_process(false)
	$HPBAR.max_value=Health
	$HPBAR.value=Health
	$HPBAR.visible=false
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

func DamageText(amount: int, duration:float =0.5):
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
	


func TakeDamage(amount: int):
	Health-=amount
	DamageText(amount)
	$HPBAR.value=Health
	$HPBAR.visible=true
	if(Health<=0):
		queue_free()
	


func _on_timer_timeout() -> void:
	var Enemies=get_tree().get_nodes_in_group("selectableUnits")
	var rng= RandomNumberGenerator.new()
	$Timer.wait_time=rng.randf_range(1,1.5)
	#print("enemy attack")
	for Enemy in Enemies:
		if((global_position-Enemy.global_position).length()<100):
			Enemy.TakeDamage(rng.randi_range(ceili(damage/1.5),ceili(damage*1.5)))
			moveSpeed=15
			#print("enemy attack")
			break
	moveSpeed=30
