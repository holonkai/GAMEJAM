extends Panel

@onready var little_guy_dialog = $littleguydialog
@onready var little_dialog_timer = $littleguydialog/littledialogtimer

var dialog_lines = [
	"dont be so mean!",
	"fight little minions!",
]

var current_index = 0 

func _ready():
	little_guy_dialog.visible = false
	little_dialog_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	little_guy_dialog.text = dialog_lines[current_index]
	little_guy_dialog.visible = true
	
	await get_tree().create_timer(2).timeout
	little_guy_dialog.visible = false 
	
	current_index = (current_index + 1) % dialog_lines.size()
	
