extends Control

enum STATE {IN_ST, TWENTYONE_ST, BUST_ST, BLACKJACK_ST}

var cur_st = STATE.IN_ST
var _score = 0 setget set_score, get_score
var _cards = []

signal hit
signal reset

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func set_score():
	
	var temp_score = 0
		
	#For every card in your hand
	for i in range(_cards.size()):
		#Add the values together
		temp_score += _cards[i].get_value()
	
	#Since the default value for an Ace is 1
	#Create a display that shows the hard and soft values for the score
	if _has_ace() && temp_score + 10 <= 21:
		temp_score += 10
		_score = temp_score
		get_node("Sorter/Score").text = str(temp_score - 10) + "/" + str(temp_score)
	else:
		_score = temp_score
		get_node("Sorter/Score").text = str(_score)
		
func _has_ace():
	for i in range(_cards.size()):
		if _cards[i].get_rank() == "Ace":
			return true	
	return false

func get_score():
	return _score

func add_card(card):
	
	#Check if the player has already busted
	if cur_st == STATE.BUST_ST:
		return
	
	#Add card to hand
	_cards.append(card)

	#File path of the card's texture
	var path_to_texture = "res://Card_Textures/" + card.get_type() + card.get_rank() + ".png"

	#Load the texture
	var texture = load(path_to_texture)

	#Display new card
	var new_card = TextureRect.new()
	new_card.texture = texture
	new_card.set_name(str("Card " + str(_cards.size())))
	$Sorter.add_child(new_card)

	#Update the score
	set_score()
	
	#Check the state of the player
	_calc_state()

func empty():
	#Remove all cards from hand
	_cards.clear()

	#For every card texture
	for i in range(1, $Sorter.get_child_count()):
		#Remove it from the game
		$Sorter.get_child(i).queue_free()

	#Set score to 0
	_score = 0
	get_node("Sorter/Score").text = "0"

func hit_me():
	emit_signal("hit", self)
	
func reset():
	empty()
	emit_signal("reset", self)
	
func _calc_state():
	#If player has less than 21
	if _score < 21:
		#Set state to still IN the game
		cur_st = STATE.IN_ST
	#If thier score is over 21 
	elif _score > 21:
		#Set thier state to bust
		cur_st = STATE.BUST_ST
	#Otherwise the player has 21
	else:
		#Set state to 21
		cur_st = STATE.TWENTYONE_ST
		
		#Check if player has Blackjack
		if _cards[0].get_rank() == "Ace" && _cards[1].get_value() == 10:
			cur_st = BLACKJACK_ST
		if _cards[1].get_rank() == "Ace" && _cards[0].get_value() == 10:
			cur_st = BLACKJACK_ST
