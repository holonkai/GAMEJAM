extends Area2D

var damage_amount = 5 

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered")) 

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		body.TakeDamage(damage_amount)
