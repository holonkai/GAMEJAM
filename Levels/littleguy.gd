extends Panel

@onready var little_guy_dialog = $littleguydialog
@onready var little_dialog_timer = $littleguydialog/littledialogtimer

func _ready():
	little_guy_dialog.visible = false
	little_dialog_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	little_guy_dialog.visible = true
	
	await get_tree().create_timer(2).timeout
	little_guy_dialog.visible = false 
