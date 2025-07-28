extends Node

var MeleeEnemy=preload("res://Prefabs/enemy.tscn")
var TestScaling: int = 1
var EnemiesLeft: int=0
var spawnDelay: float=0.0

func _on_wave_timer_timeout() -> void:
	EnemiesLeft=TestScaling
	set_process(true)
	
func _process(delta: float) -> void:
	spawnDelay+=delta
	#print(spawnDelay)
	if(EnemiesLeft>0):
		#print(spawnDelay)
		if(spawnDelay>=0.2):
			#print("spawn u fool")
			var newGuy=MeleeEnemy.instantiate()
			newGuy.position=Vector2(500,-200)
			add_child(newGuy)
			#print(newGuy.global_position)
			EnemiesLeft-=1
			spawnDelay=0
	else:
		TestScaling*=2
		set_process(false)
	
