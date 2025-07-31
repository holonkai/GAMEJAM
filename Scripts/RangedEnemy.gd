extends CharacterBody2D
#setting variables
var moveSpeed=30
var path: PackedVector2Array
var Health: int=10
var damage=1
var dmg_tw: Tween = null
var rng= RandomNumberGenerator.new()

func _ready() -> void:
	#instantiating object
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
	#tweens and animates the damage numbers
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
	#reduces health and activates the visual effects
	Health-=amount
	DamageText(amount)
	$HPBAR.value=Health
	$HPBAR.visible=true
	if(Health<=0):
		die()

#take damage from skill 
#@onready var skill_damage = 

#adds gold when minion dies(?)
@onready var mainUI: Control= get_tree().current_scene.get_node("%mainUI")

func die():
	mainUI.add_gold(4)
	$Death.pitch_scale=rng.randf_range(.8,1.2)
	$Death.play()
	await get_tree().create_timer(.2).timeout
	queue_free()

func _on_timer_timeout() -> void:
	#attacks the player minions after a random amount of time
	var Enemies=get_tree().get_nodes_in_group("selectableUnits")
	if(Enemies.size()<1):
		return
	var closest=Enemies[0]
	$Timer.wait_time=rng.randf_range(3,4)
	for Enemy in Enemies:
		if((global_position-Enemy.global_position).length()<(global_position-closest.global_position).length()):
			closest=Enemy
	if((global_position-closest.global_position).length()<200):
		closest.TakeDamage(damage)
		$Sprite2D.look_at(closest.global_position)
		$Sprite2D.rotation_degrees-=90
		$Sprite2D/LaserRay.look_at(closest.global_position)
		$Sprite2D/LaserRay.isCasting=true
		$Sprite2D/LaserRay.rotation_degrees+=5
		$LaserShootBang.pitch_scale=rng.randf_range(.8,1.2)
		$LaserShootBang.play()
		moveSpeed=0
		await get_tree().create_timer(.1).timeout
		$Sprite2D/LaserRay.isCasting=false
	else:
		moveSpeed=30
