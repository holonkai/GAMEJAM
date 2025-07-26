extends CharacterBody2D
const moveSpeed=5000.0

@export var Goal: Node = null

func _ready() -> void:
	$NavigationAgent2D.target_position=Goal.global_position

func _physics_process(delta: float) -> void:
	if(!$NavigationAgent2D.is_target_reached()):
		var navPointDirection=to_local($NavigationAgent2D.get_next_path_position()).normalized()
		velocity= navPointDirection*moveSpeed*delta
		move_and_slide()



func _on_timer_timeout() -> void:
	if $NavigationAgent2D.target_position!=Goal.global_position:
		$NavigationAgent2D.target_position=Goal.global_position

	
