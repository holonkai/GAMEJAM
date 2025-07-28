extends Panel

@onready var big_guy_dialog =  $BigGuyDialog
@onready var big_guy_timer = $BigGuyDialog/BigGuyTimer

var dialog_lines = [
	"destroy them!",
	"kill them little guys!",
]

var current_index = 0 

func _ready():
	big_guy_dialog.visible = false
	big_guy_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	big_guy_dialog.text = dialog_lines[current_index]
	big_guy_dialog.visible = true
	
	await get_tree().create_timer(2).timeout
	big_guy_dialog.visible = false 
	
	current_index = (current_index + 1) % dialog_lines.size()
