extends Node

var MeleeEnemy=preload("res://Prefabs/enemy.tscn")

var EnemiesLeft: int=0
var spawnDelay: float=0.0
var waves=[[1,1,1,1],[1,1,1,1,1,1,1,1,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]]
var TestScaling: int = waves.back().size()
func _on_wave_timer_timeout() -> void:
	EnemiesLeft=TestScaling
	set_process(true)
	
func _process(delta: float) -> void:
	spawnDelay+=delta
	if(waves.size()<1):
		set_process(false)
		return
	#print(spawnDelay)
	if(waves[0].size()>=1):
		#print(spawnDelay)
		if(spawnDelay>=0.2):
			var newGuy=MeleeEnemy.instantiate()
			newGuy.position=Vector2(500,100)
			add_child(newGuy)
			#print(newGuy.global_position)
			EnemiesLeft-=1
			spawnDelay=0
			waves[0].pop_front()
			#print(waves[0])
	else:
		if(waves.size()>1):
			waves.pop_front()
		else:
			TestScaling=floori(TestScaling*1.25)
			waves[0]=[]
			while(waves[0].size()<TestScaling):
				waves[0].append(1)
			print(waves[0].size())
			print(TestScaling)
		
		set_process(false)
	
