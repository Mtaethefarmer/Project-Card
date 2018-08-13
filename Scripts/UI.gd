extends HBoxContainer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$"Reset Btn".visible = false

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_BlackJack_World_house_turn(ignore):
	#Disable all buttons
	for button in get_children():
		button.disabled = true
	
	#Reenable reset button
	var reset_btn = get_node("Reset Btn")
	reset_btn.disabled = false

func _on_Reset_Btn_pressed():
	#Re-enable all buttons
	for button in get_children():
		button.disabled = false
	
	$"Reset Btn".visible = false

func _on_Stand_Btn_pressed():
	$"Reset Btn".visible = true
