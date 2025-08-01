extends Node
var characterPosition: int=0
var location: int=0
var tutorialList= ["Hi welcome to Little Sci-fi! :D",
	"We have a little tutorial here to ensure you are\non the right track.\nYou can press Esc to skip the tutorial\nBut that would hurt my feelings :(",
	"You see that number in the bottom left corner?",
	"That's your gold. You can use it to buy\nminions\nminion upgrades\nand skills",
	"Lets start with minions!",
	"If you left click on the top two boxes you buy\na minion\naren't they cute? :)",
	"You can then click and drag to select the minions.",
	"Finally you can right click to command them \nwhere to go.",
	"You can now send them to war >:D",
	"Next are the upgrade buttons.",
	"Clicking these buttons will upgrade minion \nhealth and damage",
	"However it only upgrades the minions \ncurrently on screen.\nNewly spawned minions do not recieve \nthe upgrades :(",
	"Finally are the skills.",
	"You click on the skills to buy them \nThen you click where you want\nthe skill to affect\nHowever they have cooldowns",
	"The skills do as follow:\nGun - Deals five damage in a group.\nUltimate - Instakills all enemies in a group. :0\nVial - Heals all minions to full.",
	"This concludes our tutorial. Esc to leave\nThank you very much for reading all of this.\nMore thank you for playing.\nWe hope you have a great time. :D",
	"Bye!",
	"So Long!",
	"See Ya!",
	"Adios!",
	"Please Egress.",
	"I can only type so many outros. :(",
	"I'm running out of space. D:",
	"I'm going on strike. >:(",
	"...",
	"......",
	"...........",
	"...................................................................................................................",
	"...................................................................................................................\n...................................................................................................................",
	"...................................................................................................................\n...................................................................................................................\n...................................................................................................................\n...................................................................................................................",
	"goodbye :)"
	]
var currentText= ""
func SetText(): 
	characterPosition=0
	$TextTimer.start()

func _input(event: InputEvent) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	#print(direction)
	if event is InputEventKey and event.pressed:
		#print(event.keycode == KEY_ESCAPE)
		if(event.keycode==KEY_ESCAPE):
			get_tree().change_scene_to_file("res://Levels/node_2d_popupscreen.tscn")
		if(direction!=0):
			if(direction>0):
				if(location+1<tutorialList.size()):
					$ArrowLeft.text="<"
					location+=1
					SetText()
					if(location+1>=tutorialList.size()):
						$ArrowRight.text=""
				else:
					$ArrowRight.text=""
			else:
				if(location>0):
					$ArrowRight.text=">"
					location-=1
					SetText()
					if(location==0):
						$ArrowLeft.text=""
				else:
					$ArrowLeft.text=""

func _on_text_timer_timeout() -> void:
	characterPosition+=1
	currentText=tutorialList[location].substr(0,characterPosition)
	$TutorialText.text=currentText
	if(characterPosition==tutorialList[location].length()):
		$TextTimer.stop()
