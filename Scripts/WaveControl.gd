extends Node

@onready var wave_label = $wavelabel

var MeleeEnemy=preload("res://Prefabs/enemy.tscn")
var RangeEnemy=preload("res://Prefabs/ranged_enemy.tscn")
var spawnDelay: float=0.0
var waves=[[1,1,0,1],[1,1,1,1,1,1,0,0,1,1],[1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0]]
var TestScaling: int = waves.back().size()
var waveCount=0
var rng= RandomNumberGenerator.new()

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	spawnDelay+=delta
	if(waves.size()<1):
		set_process(false)
		return
	#print(spawnDelay)
	if(waves[0].size()>=1):
		#print(spawnDelay)
		if(spawnDelay>=0.01):
			if(waves[0][0]==1):
				var newGuy=MeleeEnemy.instantiate()
				newGuy.position=Vector2(rng.randi_range(900,1100),rng.randi_range(0,100))
				add_sibling(newGuy)
				#print(newGuy.global_position)
			else:
				var newGuy=RangeEnemy.instantiate()
				newGuy.position=Vector2(rng.randi_range(900,1100),rng.randi_range(0,100))
				add_sibling(newGuy)
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
				waves[0].append(rng.randi_range(0,1))
			print(waves[0].size())
			#print(TestScaling)
		
		set_process(false)
	


func _on_wave_timer_timeout() -> void:
	waveCount+=1
	if wave_label:
		wave_label.text = "Wave: %d" % waveCount
	print(waveCount)
	set_process(true)
	
